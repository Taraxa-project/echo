import 'dart:async';
import 'dart:isolate';

import 'package:logging/logging.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:uuid/uuid.dart';
import 'package:telegram_client/wrap_id.dart';
import 'package:td_json_client/td_json_client.dart';

import 'isolate.dart';
import 'db.dart';

class TelegramClientIsolater extends Isolater {
  final logger = Logger('TelegramClient');

  Future<TgMsgResponseLogin> login({
    required int apiId,
    required String apiHash,
    required String phoneNumber,
    required String databasePath,
    required String Function() readTelegramCode,
    required void Function(String) writeQrCodeLink,
    required String Function() readUserFirstName,
    required String Function() readUserLastName,
    required String Function() readUserPassword,
  }) async {
    isolateSendPort.send(TgMsgRequestLogin(
      replySendPort: isolateReceivePort.sendPort,
      apiId: apiId,
      apiHash: apiHash,
      phoneNumber: phoneNumber,
      databasePath: databasePath,
      readTelegramCode: readTelegramCode,
      writeQrCodeLink: writeQrCodeLink,
      readUserFirstName: readUserFirstName,
      readUserLastName: readUserLastName,
      readUserPassword: readUserPassword,
    ));
    TgMsgResponseLogin response = await isolateReceivePortBroadcast
        .firstWhere((element) => element is TgMsgResponseLogin)
        .onError(<StateError>(error, _) => logger.warning('login $error'));

    if (response.exception != null) {
      throw response.exception!;
    }
    return response;
  }

  Future<TgMsgResponseReadChatHistory> readChatsHistory({
    required DateTime dateTimeFrom,
    required List<String> chatsNames,
  }) async {
    isolateSendPort.send(TgMsgRequestReadChatsHistory(
      replySendPort: isolateReceivePort.sendPort,
      dateTimeFrom: dateTimeFrom,
      chatsNames: chatsNames,
    ));

    TgMsgResponseReadChatHistory response = await isolateReceivePortBroadcast
        .firstWhere((element) => element is TgMsgResponseReadChatHistory)
        .onError(<StateError>(error, _) =>
            logger.warning('readChatsHistory $error'));

    if (response.exception != null) {
      throw response.exception!;
    }
    return response;
  }
}

class TelegramClient extends Isolated {
  SendPort? logSendPort;

  final SendPort dbSendPort;

  late final ReceivePort receivePort;
  late final Stream<dynamic> receivePortBroadcast;

  final String libtdjsonlcPath;
  Level? logLevelLibTdJson;
  late final TdJsonClient _tdJsonClient;
  late final int _tdJsonClientId;

  late final StreamController _tdStreamController;

  double tdReceiveWaitTimeout = 0.005;
  Duration tdReceiveFrequency = Duration(milliseconds: 10);

  Uri? proxyUri;

  bool _isTdReceiving = false;
  Timer? receiveTimer;

  static const int tgRetryCountMax = 5;
  static const int tgTimeoutMilliseconds = 15 * 1000;
  static const int tgTimeoutDelayMilliseconds = 50;
  static const int delayTimeoutSeconds = 15;

  static const int delayUntilNextChatSeconds = 300;
  static const int delayUntilNextMessageBatchSeconds = 30;
  static const int delayUntilNextUserSeconds = 5;

  static const int delayParseErrorSeconds = 60 * 60 * 24;
  static const int delayFloodWaitMultiplier = 2;

  TelegramClient({
    this.logSendPort,
    Level? super.logLevel,
    required this.dbSendPort,
    required this.libtdjsonlcPath,
    this.logLevelLibTdJson,
    this.tdReceiveWaitTimeout = 0.005,
    this.tdReceiveFrequency = const Duration(milliseconds: 10),
    this.proxyUri,
  }) {
    logger.onRecord.listen((logRecord) {
      logSendPort?.send(logRecord);
    });
  }

  Future<void> init(SendPort parentSendPort) async {
    super.init(parentSendPort);
    _initTdLib();
    await _initProxy();
  }

  void initDispatch() {
    receivePortBroadcast.listen((message) {
      if (message is IsolateMsgRequestExit) {
        logger.fine('exiting...');
        exit(message.replySendPort);
      } else if (message is TgMsgRequestLogin) {
        _login(
          apiId: message.apiId,
          apiHash: message.apiHash,
          phoneNumber: message.phoneNumber,
          databasePath: message.databasePath,
          readTelegramCode: message.readTelegramCode,
          writeQrCodeLink: message.writeQrCodeLink,
          readUserFirstName: message.readUserFirstName,
          readUserLastName: message.readUserLastName,
          readUserPassword: message.readUserPassword,
        ).then((value) => message.replySendPort?.send(value));
      } else if (message is TgMsgRequestReadChatsHistory) {
        _readChatsHistory(
          datetimeFrom: message.dateTimeFrom,
          chatsNames: message.chatsNames,
        ).then((value) => message.replySendPort?.send(value));
      }
    });
  }

  void _initTdLib() {
    logger.fine('initializing TdJsonClient...');

    _tdJsonClient = TdJsonClient(libtdjsonlcPath: libtdjsonlcPath);
    _tdJsonClientId = _tdJsonClient.create_client_id();

    final loggerTdJsonClient = Logger('TdJsonClient');
    loggerTdJsonClient.level = Level.ALL;
    loggerTdJsonClient.onRecord.listen((event) {
      logSendPort?.send(event);
    });
    final loggerLibTdJson = Logger('LibTdJson');
    loggerLibTdJson.level = logLevelLibTdJson;
    loggerLibTdJson.onRecord.listen((event) {
      logSendPort?.send(event);
    });
    _tdJsonClient.setupLogs(loggerTdJsonClient, loggerLibTdJson);

    logger.fine('created client id $_tdJsonClientId.');
    logger.fine('initialization finished.');

    _tdStreamController = StreamController.broadcast(
      onListen: _tdStart,
      onCancel: _tdStop,
    );
  }

  Future<void> _initProxy() async {
    logger.info('checking proxy...');

    if (proxyUri == null) {
      logger.info('not using proxy.');
      return;
    }

    String? username;
    String? password;

    if (proxyUri?.userInfo != null) {
      RegExp exp = RegExp(r'(\w+)');
      Iterable<RegExpMatch> matches = exp.allMatches(proxyUri!.userInfo);
      if (matches.length == 2) {
        username = matches.elementAt(0)[0];
        password = matches.elementAt(1)[0];
      }
    }

    ProxyType? proxyType;

    if (proxyUri?.scheme == 'http') {
      proxyType = ProxyTypeHttp(
        username: username,
        password: password,
      );
    } else if (proxyUri?.scheme == 'socks5') {
      proxyType = ProxyTypeSocks5(
        username: username,
        password: password,
      );
    }

    if (proxyType == null) {
      logger.warning('invalid proxy scheme ${proxyUri?.scheme}.'
          ' Not using proxy.');
      return;
    }

    await _addProxy(
      server: proxyUri?.host,
      port: proxyUri?.port,
      proxyType: proxyType,
    );
  }

  Future<void> exit(SendPort? replySendPort) async {
    await _close();

    _tdJsonClient.exit();
    await _tdStreamController.close();

    replySendPort?.send(IsolateMsgResponseExit());
    await Future.delayed(const Duration(milliseconds: 100));

    logger.fine('closing tg isolate port');
    receivePort.close();
    Isolate.exit();
  }

  void _tdStart() {
    logger.fine('starting the receive timer...');
    receiveTimer = Timer.periodic(tdReceiveFrequency, _tdReceive);
    logger.fine('receive timer started.');
  }

  void _tdStop() {
    logger.fine('stopping the receive timer...');
    receiveTimer?.cancel();
    receiveTimer = null;
    logger.fine('receive timer stopped.');
  }

  void _tdReceive(Timer timer) {
    if (!_isTdReceiving) {
      _isTdReceiving = true;

      var event = _tdJsonClient.receive(waitTimeout: tdReceiveWaitTimeout);
      if (event != null) {
        logger.finer('received ${event.runtimeType}.');
        if (event is UpdateConnectionState) {
          _handleUpdateConnectionState(event);
        }
        _tdStreamController.add(event);
      }

      _isTdReceiving = false;
    }
  }

  void _tdSend(
    TdFunction tdFunction,
  ) {
    logger.fine('sending ${tdFunction.runtimeType}...');
    logger.finer('sending $tdFunction...');
    _tdJsonClient.send(_tdJsonClientId, tdFunction);
    logger.fine('sent ${tdFunction.runtimeType}.');
  }

  Future<TdObject> _tdCall({
    required TdFunction tdFunction,
    int timeoutMilliseconds = tgTimeoutMilliseconds,
  }) async {
    var tdResponse;

    var extra = Uuid().v1();

    var sub = _tdStreamController.stream
        .where((event) => event.extra == extra)
        .listen((event) {
      tdResponse = event;
    });

    tdFunction.extra = extra;
    _tdSend(tdFunction);

    int elapsedMilliseconds = 0;
    while (elapsedMilliseconds <= timeoutMilliseconds) {
      if (tdResponse != null) {
        break;
      }
      elapsedMilliseconds += tgTimeoutDelayMilliseconds;
      await Future.delayed(Duration(milliseconds: tgTimeoutDelayMilliseconds));
    }

    sub.cancel();

    if (tdResponse == null) {
      throw TgTimeOutException(
        elapsedMilliseconds,
        tdFunction.runtimeType.toString(),
      );
    } else if (tdResponse is Error) {
      _handleTdError(tdResponse);
    } else {
      return tdResponse;
    }
  }

  Future<TdObject> _retryTdCall({
    required TdFunction tdFunction,
    int timeoutMilliseconds = tgTimeoutMilliseconds,
    int retryCountMax = tgRetryCountMax,
  }) async {
    var retryCountIndex = 0;
    while (retryCountIndex < retryCountMax) {
      retryCountIndex += 1;

      try {
        return await _tdCall(
          tdFunction: tdFunction,
          timeoutMilliseconds: timeoutMilliseconds,
        );
      } on TgFloodWaiException catch (ex) {
        logger.warning('received flood wait for '
            '${tdFunction.runtimeType.toString()}. '
            'Retrying in ${ex.waitSeconds} seconds.');
        await Future.delayed(Duration(seconds: ex.waitSeconds));
        continue;
      } on TgTimeOutException {
        logger.warning('time out for '
            '${tdFunction.runtimeType.toString()}. '
            'Retrying in ${delayTimeoutSeconds} seconds.');
        await Future.delayed(Duration(seconds: delayTimeoutSeconds));
        continue;
      }
    }

    throw TgMaxRetriesExcedeedException(retryCountMax);
  }

  void _handleUpdateConnectionState(
      UpdateConnectionState updateConnectionState) {
    var state = updateConnectionState.state;
    if (state == null) {
      logger.severe('connection state unknown.');
    } else {
      logger.info('connection state: ${state.runtimeType}.');
    }
  }

  Future<Ok> _close({
    int timeoutMilliseconds = tgTimeoutMilliseconds,
    int retryCountMax = tgRetryCountMax,
  }) async {
    return await _retryTdCall(
      tdFunction: Close(),
      timeoutMilliseconds: timeoutMilliseconds,
      retryCountMax: retryCountMax,
    ) as Ok;
  }

  Future<TgMsgResponseLogin> _login({
    required int apiId,
    required String apiHash,
    required String phoneNumber,
    required String databasePath,
    required String Function() readTelegramCode,
    required void Function(String) writeQrCodeLink,
    required String Function() readUserFirstName,
    required String Function() readUserLastName,
    required String Function() readUserPassword,
  }) async {
    logger.info('logging in...');

    var isAuthorized = false;
    var exception;

    var sub = _tdStreamController.stream.listen((event) {
      if (event is UpdateAuthorizationState) {
        logger
            .info('login: received ${event.authorization_state.runtimeType}.');

        var authorizationState = event.authorization_state;
        if (authorizationState is AuthorizationStateWaitTdlibParameters) {
          _setTdlibParameters(
            apiId: apiId,
            apiHash: apiHash,
            databasePath: databasePath,
          ).then((value) {
            logger.info('login: SetTdlibParameters done.');
          }).catchError((error, _) {
            exception = error;
          });
        } else if (authorizationState is AuthorizationStateWaitPhoneNumber) {
          _setAuthenticationPhoneNumber(
            phoneNumber: phoneNumber,
          ).then((value) {
            logger.info('login: SetAuthenticationPhoneNumber done.');
          }).catchError((error, _) {
            exception = error;
          });
        } else if (authorizationState is AuthorizationStateWaitCode) {
          _checkAuthenticationCode(
            readTelegramCode: readTelegramCode,
          ).then((value) {
            logger.info('login: CheckAuthenticationCode done.');
          }).catchError((error, _) {
            exception = error;
          });
        } else if (authorizationState
            is AuthorizationStateWaitOtherDeviceConfirmation) {
          writeQrCodeLink(authorizationState.link ?? '');
        } else if (authorizationState is AuthorizationStateWaitRegistration) {
          _registerUser(
            readUserFirstName: readUserFirstName,
            readUserLastName: readUserLastName,
          ).then((value) {
            logger.info('login: RegisterUser done.');
          }).catchError((error, _) {
            exception = error;
          });
        } else if (authorizationState is AuthorizationStateWaitPassword) {
          _checkAuthenticationPassword(
            readUserPassword: readUserPassword,
          ).then((value) {
            logger.info('login: CheckAuthenticationPassword done.');
          }).catchError((error, _) {
            exception = error;
          });
        } else if (authorizationState is AuthorizationStateReady) {
          isAuthorized = true;
        }
      }
    });

    _tdSend(GetAuthorizationState(
      extra: Uuid().v1(),
    ));

    while (true) {
      if (isAuthorized) {
        logger.info('login: success.');
        break;
      }
      if (exception != null) {
        break;
      }
      await Future.delayed(const Duration(milliseconds: 100));
    }

    sub.cancel();

    return TgMsgResponseLogin(
      isAuthorized: isAuthorized,
      exception: exception,
    );
  }

  Future<TdObject> _setTdlibParameters({
    required int apiId,
    required String apiHash,
    required String databasePath,
    int timeoutMilliseconds = tgTimeoutMilliseconds,
  }) {
    logger.info('login: sending SetTdlibParameters...');
    return _tdCall(
      tdFunction: SetTdlibParameters(
        api_id: apiId,
        api_hash: apiHash,
        database_directory: databasePath,
        use_message_database: false,
        device_model: 'Desktop',
        application_version: '1.0',
        system_language_code: 'en',
        database_encryption_key: '',
      ),
      timeoutMilliseconds: timeoutMilliseconds,
    );
  }

  Future<dynamic> _setAuthenticationPhoneNumber({
    required String phoneNumber,
    int timeoutMilliseconds = tgTimeoutMilliseconds,
  }) async {
    logger.info('login: sending SetAuthenticationPhoneNumber...');
    return await _retryTdCall(
      tdFunction: SetAuthenticationPhoneNumber(
        phone_number: phoneNumber,
      ),
      timeoutMilliseconds: timeoutMilliseconds,
    );
  }

  Future<TdObject> _checkAuthenticationCode({
    required String Function() readTelegramCode,
    int timeoutMilliseconds = tgTimeoutMilliseconds,
  }) async {
    logger.info('login: sending CheckAuthenticationCode...');
    return await _tdCall(
      tdFunction: CheckAuthenticationCode(
        code: readTelegramCode(),
      ),
      timeoutMilliseconds: timeoutMilliseconds,
    );
  }

  Future<TdObject> _registerUser({
    required String Function() readUserFirstName,
    required String Function() readUserLastName,
    int timeoutMilliseconds = tgTimeoutMilliseconds,
  }) async {
    logger.info('login: sending RegisterUser...');
    return await _tdCall(
      tdFunction: RegisterUser(
        first_name: readUserFirstName(),
        last_name: readUserLastName(),
      ),
      timeoutMilliseconds: timeoutMilliseconds,
    );
  }

  Future<TdObject> _checkAuthenticationPassword({
    required String Function() readUserPassword,
    int timeoutMilliseconds = tgTimeoutMilliseconds,
  }) async {
    logger.info('login: sending CheckAuthenticationPassword...');
    return await _retryTdCall(
      tdFunction: CheckAuthenticationPassword(
        password: readUserPassword(),
      ),
      timeoutMilliseconds: timeoutMilliseconds,
    );
  }

  Future<TgMsgResponseReadChatHistory> _readChatsHistory({
    required DateTime datetimeFrom,
    required List<String> chatsNames,
  }) async {
    try {
      await _addChats(usernames: chatsNames);
    } on TgDbException catch (ex) {
      return TgMsgResponseReadChatHistory(exception: ex);
    }

    logger.info('reading chats history...');

    for (final chatName in chatsNames) {
      logger.info('[$chatName] reading chat history...');

      try {
        await _readChatHistory(
          dateTimeFrom: datetimeFrom,
          chatName: chatName,
        );
      } on TgChatNotFoundException catch (ex) {
        logger.warning('[$chatName] $ex.');
        try {
          await _blacklistChat(
            chatName: chatName,
            reason: ex.message ?? 'Chat not found.',
          );
        } on TgDbException catch (ex) {
          return TgMsgResponseReadChatHistory(exception: ex);
        }
      } on TgTimeOutException catch (ex) {
        logger.warning('[$chatName] $ex.');
      } on TgMaxRetriesExcedeedException catch (ex) {
        logger.warning('[$chatName] $ex.');
      } on TgBadRequestException catch (ex) {
        logger.severe('[$chatName] $ex.');
      } on UnWrapIdxception catch (ex) {
        logger.warning('[$chatName] $ex.');
      } on TgErrorCodeNotHandledException catch (ex) {
        logger.severe('[$chatName] $ex.');
      } on TgException catch (ex) {
        logger.severe('[$chatName] $ex.');
      } on TgDbException catch (ex) {
        return TgMsgResponseReadChatHistory(exception: ex);
      }

      logger.info('[$chatName] reading chat history... done.');

      logger.info('reading chats history... '
          'sleeping for $delayUntilNextChatSeconds seconds.');
      await Future.delayed(const Duration(seconds: delayUntilNextChatSeconds));
    }
    return TgMsgResponseReadChatHistory();
  }

  Future<void> _readChatHistory({
    required DateTime dateTimeFrom,
    required String chatName,
  }) async {
    final chat = await _searchPublicChat(chatName: chatName);

    final chatId = WrapId.unwrapChatId(chat.id);
    logger.info('[$chatName] unwrapped chat id is $chatId.');

    await _updateChat(
      chatName: chatName,
      chat: chat,
    );

    logger.info('[$chatName] getting supergroup full info... ');
    final supergroupFullInfo = await _getSupergroupFullInfo(
      chatName: chatName,
      chatId: chatId,
    );
    if (supergroupFullInfo.member_count != null &&
        supergroupFullInfo.member_count != 0) {
      logger.info('[$chatName] member count is '
          '${supergroupFullInfo.member_count}.');
      await _updateChatMembersCount(
        chatName: chatName,
        memberCount: supergroupFullInfo.member_count!,
      );
    }

    logger.info('[$chatName] check online member count... ');
    final subscriptionUpdateChatOnlineMemberCount =
        _subscribeUpdateChatOnlineMemberCount(
      chatName: chatName,
      chatId: chatId,
    );

    logger.info('[$chatName] opening chat... ');
    await _openChat(chatName: chatName, chatId: chatId);

    logger.info('[$chatName] getting bot count... ');
    final chatMembersBots = await _getSupergroupMembers(
      chatName: chatName,
      chatId: chatId,
      supergroupMembersFilter: SupergroupMembersFilterBots(),
    );
    if (chatMembersBots.members != null) {
      logger.info('[$chatName] bot count is '
          '${chatMembersBots.members!.length}.');
      await _updateChatMembersBotsCount(
        chatName: chatName,
        memberCount: chatMembersBots.members!.length,
      );
    }

    await subscriptionUpdateChatOnlineMemberCount.cancel();

    logger.info('[$chatName] closing chat... ');
    await _closeChat(chatName: chatName, chatId: chatId);

    var messageIdLast = await _searchMessageIdLast(
      datetimeFrom: dateTimeFrom,
      chatName: chatName,
      chatId: chatId,
    );
    if (messageIdLast == null) {
      messageIdLast = 0;
    }

    var onlineMemberCount = await _selectOnlineMemberCount(chatName: chatName);

    while (true) {
      var messageIdFrom = messageIdLast! + 1;
      logger.info('[$chatName] reading messages from $messageIdFrom... ');

      final messages = await _getChatHistory(
        chatName: chatName,
        chatId: chatId,
        messageIdFrom: messageIdFrom,
      );

      if (messages.messages == null || messages.messages?.length == 0) {
        break;
      }

      messageIdLast = await _saveMessages(
        chatName: chatName,
        chatId: chatId,
        messages: messages,
        onlineMemberCount: onlineMemberCount,
      );

      await _saveUsers(
        chatName: chatName,
        messages: messages,
      );

      if (messageIdLast == null) {
        break;
      }

      logger.info('[$chatName] reading messages... '
          'sleeping for $delayUntilNextMessageBatchSeconds seconds.');
      await Future.delayed(const Duration(
        seconds: delayUntilNextMessageBatchSeconds,
      ));
    }
  }

  Future<void> _updateUser({required int userId, required User user}) async {
    dbSendPort.send(DbMsgRequestUpdateUser(
        replySendPort: receivePort.sendPort, userId: userId, user: user));
    var response = await receivePortBroadcast
        .where((event) => event is DbMsgResponseUpdateUser)
        .first;

    if (response.exception != null) {
      throw TgDbException(
          exception: response.exception, operationName: response.operationName);
    }
    logger.fine('[$userId] added user to user table.');
  }

  Future<void> _saveUsers({
    required String chatName,
    required Messages messages,
  }) async {
    var userCount = 0;
    for (Message message in messages.messages!) {
      var userId = null;

      if (message.sender_id != null &&
          message.sender_id.runtimeType == MessageSenderUser) {
        userId = (message.sender_id as MessageSenderUser).user_id;
      }

      if (userId != null) {
        dbSendPort.send(DbMsgRequestAddUser(
            replySendPort: receivePort.sendPort, userId: userId));
        DbMsgResponseAddUser response = await receivePortBroadcast
            .where((event) => event is DbMsgResponseAddUser)
            .first;

        if (response.exception != null) {
          if (response is DbMsgResponseConstraintError) {
            logger.fine('[${userId}] already exists');
          } else {
            throw TgDbException(
                exception: response.exception,
                operationName: response.operationName);
          }
        } else {
          if (userCount == 0) {
            logger.info('[$chatName] saving users...');
            logger.info('[$chatName] getting users...');
          }
          logger.fine('[$chatName] getting user $userId... ');
          var user = await _getUser(userId: userId);
          await _updateUser(userId: userId, user: user);
          userCount += 1;

          logger.fine('[$chatName] getting user... '
              'sleeping for $delayUntilNextUserSeconds seconds.');
          await Future.delayed(
              const Duration(seconds: delayUntilNextUserSeconds));
        }
      }
    }

    if (userCount > 0) {
      logger.info('[$chatName] saved $userCount users.');
    }
  }

  Future<User> _getUser({
    required int userId,
    int timeoutMilliseconds = tgTimeoutMilliseconds,
    int retryCountMax = tgRetryCountMax,
  }) async {
    return await _retryTdCall(
      tdFunction: GetUser(
        user_id: userId,
      ),
      timeoutMilliseconds: timeoutMilliseconds,
      retryCountMax: retryCountMax,
    ) as User;
  }

  Future<Chat> _searchPublicChat({
    required String chatName,
    int timeoutMilliseconds = tgTimeoutMilliseconds,
    int retryCountMax = tgRetryCountMax,
  }) async {
    Chat chat;
    try {
      chat = await _retryTdCall(
        tdFunction: SearchPublicChat(
          username: chatName,
        ),
        timeoutMilliseconds: timeoutMilliseconds,
        retryCountMax: retryCountMax,
      ) as Chat;
    } on TgBadRequestException catch (ex) {
      throw TgChatNotFoundException(ex.toString());
    }

    if (chat.id == null) {
      throw TgChatNotFoundException('Chat.id is null');
    } else if (chat.type == null) {
      throw TgChatNotFoundException('Chat.type is null');
    } else if (!(chat.type is ChatTypeSupergroup)) {
      throw TgChatNotFoundException('Invalid Chat.type: '
          '${chat.type.runtimeType}');
    }

    return chat;
  }

  Future<Ok> _openChat({
    required String chatName,
    required int chatId,
    int timeoutMilliseconds = tgTimeoutMilliseconds,
    int retryCountMax = tgRetryCountMax,
  }) async {
    return await _retryTdCall(
      tdFunction: OpenChat(
        chat_id: WrapId.wrapChatId(chatId),
      ),
      timeoutMilliseconds: timeoutMilliseconds,
      retryCountMax: retryCountMax,
    ) as Ok;
  }

  Future<Ok> _closeChat({
    required String chatName,
    required int chatId,
    int timeoutMilliseconds = tgTimeoutMilliseconds,
    int retryCountMax = tgRetryCountMax,
  }) async {
    return await _retryTdCall(
      tdFunction: CloseChat(
        chat_id: WrapId.wrapChatId(chatId),
      ),
      timeoutMilliseconds: timeoutMilliseconds,
      retryCountMax: retryCountMax,
    ) as Ok;
  }

  Future<SupergroupFullInfo> _getSupergroupFullInfo({
    required String chatName,
    required int chatId,
    int timeoutMilliseconds = tgTimeoutMilliseconds,
    int retryCountMax = tgRetryCountMax,
  }) async {
    return await _retryTdCall(
      tdFunction: GetSupergroupFullInfo(
        supergroup_id: chatId,
      ),
      timeoutMilliseconds: timeoutMilliseconds,
      retryCountMax: retryCountMax,
    ) as SupergroupFullInfo;
  }

  Future<ChatMembers> _getSupergroupMembers({
    required String chatName,
    required int chatId,
    SupergroupMembersFilter? supergroupMembersFilter,
    int timeoutMilliseconds = tgTimeoutMilliseconds,
    int retryCountMax = tgRetryCountMax,
  }) async {
    return await _retryTdCall(
      tdFunction: GetSupergroupMembers(
        supergroup_id: chatId,
        filter: supergroupMembersFilter,
        offset: 0,
        limit: 200,
      ),
      timeoutMilliseconds: timeoutMilliseconds,
      retryCountMax: retryCountMax,
    ) as ChatMembers;
  }

  Future<int?> _searchMessageIdLast({
    required DateTime datetimeFrom,
    required String chatName,
    required int chatId,
    int timeoutMilliseconds = tgTimeoutMilliseconds,
    int retryCountMax = tgRetryCountMax,
  }) async {
    logger.info('[$chatName] searching last message by date...');

    var messageIdLast = await _searchMessageIdLastLocally(
      dateTimeFrom: datetimeFrom,
      chatName: chatName,
      chatId: chatId,
    );

    if (messageIdLast == null) {
      messageIdLast = await _searchMessageIdLastRemote(
        datetimeFrom: datetimeFrom,
        chatName: chatName,
        chatId: chatId,
        timeoutMilliseconds: timeoutMilliseconds,
        retryCountMax: retryCountMax,
      );
    }

    logger.info('[$chatName] searching last message by date... done.');

    return messageIdLast;
  }

  Future<int?> _searchMessageIdLastRemote({
    required String chatName,
    required int chatId,
    required DateTime datetimeFrom,
    int timeoutMilliseconds = tgTimeoutMilliseconds,
    int retryCountMax = tgRetryCountMax,
  }) async {
    logger.info('[$chatName] searching last message id remote...');

    int? messageIdLast;
    try {
      final tdResponse = await _getChatMessageByDate(
        chatName: chatName,
        chatId: chatId,
        datetimeFrom: datetimeFrom,
        timeoutMilliseconds: timeoutMilliseconds,
        retryCountMax: retryCountMax,
      );
      messageIdLast = WrapId.unwrapMessageId(tdResponse.id);
      logger.info('[$chatName] searching last message id remote... '
          'found $messageIdLast.');
    } on TgNotFoundException {
      logger.info('[$chatName] searching last message id remote... '
          'not found.');
    } on UnWrapIdxception {
      logger.info('[$chatName] searching last message id remote... '
          'not found.');
    }

    return messageIdLast;
  }

  Future<Message> _getChatMessageByDate({
    required String chatName,
    required int chatId,
    required DateTime datetimeFrom,
    int timeoutMilliseconds = tgTimeoutMilliseconds,
    int retryCountMax = tgRetryCountMax,
  }) async {
    return await _retryTdCall(
      tdFunction: GetChatMessageByDate(
        chat_id: WrapId.wrapChatId(chatId),
        date: datetimeFrom.millisecondsSinceEpoch ~/ 1000,
      ),
      timeoutMilliseconds: timeoutMilliseconds,
      retryCountMax: retryCountMax,
    ) as Message;
  }

  Future<Messages> _getChatHistory({
    required String chatName,
    required int chatId,
    required int messageIdFrom,
    int timeoutMilliseconds = tgTimeoutMilliseconds,
    int retryCountMax = tgRetryCountMax,
  }) async {
    return await _retryTdCall(
      tdFunction: GetChatHistory(
        chat_id: WrapId.wrapChatId(chatId),
        from_message_id: WrapId.wrapMessageId(messageIdFrom),
        offset: -99,
        limit: 99,
        only_local: false,
      ),
      timeoutMilliseconds: timeoutMilliseconds,
      retryCountMax: retryCountMax,
    ) as Messages;
  }

  StreamSubscription<dynamic> _subscribeUpdateChatOnlineMemberCount({
    required String chatName,
    required int chatId,
  }) {
    return _tdStreamController.stream
        .where((event) =>
            event is UpdateChatOnlineMemberCount &&
            event.chat_id == WrapId.wrapChatId(chatId))
        .listen((event) {
      final updateChatOnlineMemberCount = event as UpdateChatOnlineMemberCount;
      if (updateChatOnlineMemberCount.online_member_count != null) {
        if (updateChatOnlineMemberCount.online_member_count != 0) {
          logger.info('[$chatName] online member count is '
              '${updateChatOnlineMemberCount.online_member_count}.');
          _updateChatMembersOnlineCount(
              chatName: chatName,
              memberCount: updateChatOnlineMemberCount.online_member_count!);
        }
      }
    });
  }

  Future<Proxy> _addProxy({
    String? server,
    int? port,
    ProxyType? proxyType,
    int timeoutMilliseconds = tgTimeoutMilliseconds,
    int retryCountMax = tgRetryCountMax,
  }) async {
    logger.info('adding proxy...');

    return await _retryTdCall(
      tdFunction: AddProxy(
        server: server,
        port: port,
        type: proxyType,
        enable: true,
      ),
      timeoutMilliseconds: timeoutMilliseconds,
      retryCountMax: retryCountMax,
    ) as Proxy;
  }

  Future<void> _addChats({
    required List<String> usernames,
  }) async {
    logger.info('adding chats to db...');

    dbSendPort.send(DbMsgRequestAddChats(
      replySendPort: receivePort.sendPort,
      usernames: usernames,
    ));
    var response = await receivePortBroadcast
        .where((event) => event is DbMsgResponseAddChats)
        .first;

    if (response.exception != null) {
      throw TgDbException(
          exception: response.exception, operationName: response.operationName);
    }

    logger.info('added ${usernames.length} chats to db...');
  }

  Future<void> _updateChat({
    required String chatName,
    required Chat chat,
  }) async {
    logger.info('[$chatName] updating chat in db...');

    dbSendPort.send(DbMsgRequestUpdateChat(
      replySendPort: receivePort.sendPort,
      username: chatName,
      chat: chat,
    ));
    var response = await receivePortBroadcast
        .where((event) => event is DbMsgResponseUpdateChat)
        .first;

    if (response.exception != null) {
      throw TgDbException(
          exception: response.exception, operationName: response.operationName);
    }
    logger.info('[$chatName] updating chat in db... done.');
  }

  Future<void> _updateChatMembersCount({
    required String chatName,
    required int memberCount,
  }) async {
    logger.info('[$chatName] updating chat member count in db...');

    dbSendPort.send(DbMsgRequestUpdateChatMembersCount(
      replySendPort: receivePort.sendPort,
      username: chatName,
      membersCount: memberCount,
    ));
    var response = await receivePortBroadcast
        .where((event) => event is DbMsgResponseUpdateChatMembersCount)
        .first;

    if (response.exception != null) {
      throw TgDbException(
          exception: response.exception, operationName: response.operationName);
    } else {
      logger.info('[$chatName] updating chat member count in db... done.');
    }
  }

  Future<void> _updateChatMembersBotsCount({
    required String chatName,
    required int memberCount,
  }) async {
    logger.info('[$chatName] updating chat bot count in db...');

    dbSendPort.send(DbMsgRequestUpdateChatMembersBotsCount(
      replySendPort: receivePort.sendPort,
      username: chatName,
      membersCount: memberCount,
    ));
    var response = await receivePortBroadcast
        .where((event) => event is DbMsgResponseUpdateChatMembersBotsCount)
        .first;

    if (response.exception != null) {
      throw TgDbException(
          exception: response.exception, operationName: response.operationName);
    } else {
      logger.info('[$chatName] updating chat bot count in db... done.');
    }
  }

  Future<void> _updateChatMembersOnlineCount({
    required String chatName,
    required int memberCount,
  }) async {
    logger.info('[$chatName] updating chat online member count in db...');

    dbSendPort.send(DbMsgRequestUpdateChatMembersOnlineCount(
      replySendPort: receivePort.sendPort,
      username: chatName,
      membersCount: memberCount,
    ));
    await receivePortBroadcast
        .where((event) => event is DbMsgResponseUpdateChatMembersOnlineCount)
        .first;

    logger.info('[$chatName] updating chat online member count in db... done.');
  }

  Future<void> _blacklistChat({
    required String chatName,
    required String reason,
  }) async {
    logger.info('[$chatName] blacklisting chat in db... '
        'Reason: $reason.');

    dbSendPort.send(DbMsgRequestBlacklistChat(
      replySendPort: receivePort.sendPort,
      username: chatName,
      reason: reason,
    ));
    var response = await receivePortBroadcast
        .where((event) => event is DbMsgResponseBlacklistChat)
        .first;

    if (response.exception != null) {
      throw TgDbException(
          exception: response.exception, operationName: response.operationName);
    } else {
      logger.info('[$chatName] blacklisting chat in db... done.');
    }
  }

  Future<int?> _saveMessages({
    required String chatName,
    required int chatId,
    required Messages messages,
    required int? onlineMemberCount,
  }) async {
    logger.info('[$chatName] saving messages...');

    var messageCount = 0;

    var messageIdLast;

    for (Message message in messages.messages!) {
      dbSendPort.send(DbMsgRequestAddMessage(
        replySendPort: receivePort.sendPort,
        message: message,
        onlineMemberCount: onlineMemberCount,
      ));
      var response = await receivePortBroadcast
          .where((event) => event is DbMsgResponseAddMessage)
          .first;

      if (response.exception != null) {
        throw TgDbException(
            exception: response.exception,
            operationName: response.operationName);
      }

      messageCount += 1;

      int messageId;
      try {
        messageId = WrapId.unwrapMessageId(message.id);
      } on UnWrapIdxception catch (ex) {
        logger.severe(ex);
        continue;
      }

      if (messageIdLast == null) {
        messageIdLast = messageId;
      } else if (messageId > messageIdLast) {
        messageIdLast = messageId;
      }
    }

    logger.info('[$chatName] saved ${messageCount} messages.');

    return messageIdLast;
  }

  Future<int?> _searchMessageIdLastLocally({
    required DateTime dateTimeFrom,
    required String chatName,
    required int chatId,
  }) async {
    logger.info('[$chatName] searching last message id locally...');

    dbSendPort.send(DbMsgRequestSelectMaxMessageId(
      replySendPort: receivePort.sendPort,
      chatId: chatId,
      dateTimeFrom: dateTimeFrom,
    ));
    var response = await receivePortBroadcast
        .where((event) => event is DbMsgResponseSelectMaxMessageId)
        .first;

    if (response.exception != null) {
      logger.info('[_searchMessageIdLastLocally] db error occured');
      throw TgDbException(
          exception: response.exception, operationName: response.operationName);
    } else if (response.id == null) {
      logger.info('[$chatName] searching last message id locally... '
          'not found.');
    } else {
      logger.info('[$chatName] searching last message id locally... '
          'found ${response.id}.');
    }

    logger.info('[$chatName] searching last message id locally... done.');

    return response.id;
  }

  Future<int?> _selectOnlineMemberCount({
    required String chatName,
  }) async {
    logger.info('[$chatName] selecting online member count locally...');

    dbSendPort.send(DbMsgRequestSelectChatOnlineMemberCount(
      replySendPort: receivePort.sendPort,
      chatName: chatName,
    ));
    var response = await receivePortBroadcast
        .where((event) => event is DbMsgResponseSelectChatOnlineMemberCount)
        .first as DbMsgResponseSelectChatOnlineMemberCount;

    if (response.exception != null) {
      logger.info('[_selectOnlineMemberCount] db error occured');
      throw TgDbException(
          exception: response.exception, operationName: response.operationName);
    } else if (response.onlineMemberCount == null) {
      logger.info('[$chatName] searching online member count locally... '
          'not found.');
    } else {
      logger.info('[$chatName] searching online member count locally... '
          'found ${response.onlineMemberCount}.');
    }

    logger.info('[$chatName] searching online member count locally... done.');

    return response.onlineMemberCount;
  }

  int? _parseFloodWaitSeconds(String? message) {
    return _parseSeconds(message, 'FLOOD_WAIT_');
  }

  int? _parseTooManyRequestsSeconds(String? message) {
    return _parseSeconds(message, 'Too Many Requests: retry after ');
  }

  int? _parseSeconds(String? message, String replace) {
    return int.tryParse(message?.replaceFirst(replace, '') ?? '');
  }

  Never _handleTdError(Error error) {
    // TODO handle
    // 401 UNAUTHORIZED
    // 403 FORBIDDEN
    // 404 NOT_FOUND
    // 500 INTERNAL
    if (error.code == 400) {
      throw TgBadRequestException(
        error.message,
        error.code,
      );
    } else if (error.code == 420) {
      var floodWaitSeconds = _parseFloodWaitSeconds(error.message);
      if (floodWaitSeconds == null) {
        logger.warning('could not parse flood wait seconds: '
            '${error.message}. '
            'Using default: $delayParseErrorSeconds seconds.');
        throw TgFloodWaiException(delayParseErrorSeconds);
      } else {
        throw TgFloodWaiException(floodWaitSeconds * delayFloodWaitMultiplier);
      }
    } else if (error.code == 429) {
      var floodWaitSeconds = _parseTooManyRequestsSeconds(error.message);
      if (floodWaitSeconds == null) {
        logger.warning('could not parse too many requests wait seconds: '
            '${error.message}. '
            'Using default: $delayParseErrorSeconds seconds.');
        throw TgFloodWaiException(delayParseErrorSeconds);
      } else {
        throw TgFloodWaiException(floodWaitSeconds * delayFloodWaitMultiplier);
      }
    } else if (error.code == 404) {
      throw TgNotFoundException(
        error.message,
        error.code,
      );
    } else if (error.code == 406) {
      throw TgNotExceptableException(
        'Handle me: '
        'https://core.telegram.org/api/errors#406-not-acceptable',
        error.code,
      );
    } else {
      throw TgErrorCodeNotHandledException(
        error.message,
        error.code,
      );
    }
  }
}

abstract class TgMsgResponse extends IsolateMsgResponse {
  final Exception? exception;
  TgMsgResponse({this.exception});
}

class TgMsgRequestExit extends IsolateMsgRequest {
  TgMsgRequestExit({super.replySendPort});
}

class TgMsgRequestLogin extends IsolateMsgRequest {
  final int apiId;
  final String apiHash;
  final String phoneNumber;
  final String databasePath;
  final String Function() readTelegramCode;
  final void Function(String) writeQrCodeLink;
  final String Function() readUserFirstName;
  final String Function() readUserLastName;
  final String Function() readUserPassword;
  TgMsgRequestLogin({
    super.replySendPort,
    required this.apiId,
    required this.apiHash,
    required this.phoneNumber,
    required this.databasePath,
    required String Function() this.readTelegramCode,
    required void Function(String) this.writeQrCodeLink,
    required String Function() this.readUserFirstName,
    required String Function() this.readUserLastName,
    required String Function() this.readUserPassword,
  });
}

class TgMsgResponseLogin extends TgMsgResponse {
  bool isAuthorized = false;
  TgMsgResponseLogin({
    required this.isAuthorized,
    super.exception,
  });
}

class TgMsgRequestReadChatsHistory extends IsolateMsgRequest {
  final DateTime dateTimeFrom;
  final List<string> chatsNames;
  TgMsgRequestReadChatsHistory({
    super.replySendPort,
    required this.dateTimeFrom,
    required this.chatsNames,
  });
}

class TgMsgResponseReadChatHistory extends TgMsgResponse {
  TgMsgResponseReadChatHistory({super.exception});
}

class TgException implements Exception {
  final String? message;

  TgException([this.message = '']);

  String toString() {
    var report = 'TgException';
    if (message != null) {
      report += ': $message';
    }
    return report;
  }
}

class TgChatNotFoundException implements Exception {
  final String? message;
  final int? code;

  TgChatNotFoundException([
    this.message = '',
    this.code = 0,
  ]);

  String toString() {
    var report = 'TgChatNotFoundException';
    if (message != null) {
      report += ': $message';
    }
    if (code != null) {
      report += ', code: $code';
    }
    return report;
  }
}

class TgBadRequestException implements Exception {
  final String? message;
  final int? code;

  TgBadRequestException([
    this.message = '',
    this.code = 0,
  ]);

  String toString() {
    var report = 'TgBadRequestException';
    if (message != null) {
      report += ': $message';
    }
    if (code != null) {
      report += ', code: $code';
    }
    return report;
  }
}

class TgNotFoundException implements Exception {
  final String? message;
  final int? code;

  TgNotFoundException([
    this.message = '',
    this.code = 0,
  ]);

  String toString() {
    var report = 'TgNotFoundException';
    if (message != null) {
      report += ': $message';
    }
    if (code != null) {
      report += ', code: $code';
    }
    return report;
  }
}

class TgNotExceptableException implements Exception {
  final String? message;
  final int? code;

  TgNotExceptableException([
    this.message = '',
    this.code = 0,
  ]);

  String toString() {
    var report = 'TgNotExceptableException';
    if (message != null) {
      report += ': $message';
    }
    if (code != null) {
      report += ', code: $code';
    }
    return report;
  }
}

class TgErrorCodeNotHandledException implements Exception {
  final String? message;
  final int? code;

  TgErrorCodeNotHandledException([
    this.message = '',
    this.code = 0,
  ]);

  String toString() {
    var report = 'TgErrorCodeNotHandledException';
    if (message != null) {
      report += ': $message';
    }
    if (code != null) {
      report += ', code: $code';
    }
    return report;
  }
}

class TgFloodWaiException implements Exception {
  final int waitSeconds;

  TgFloodWaiException(
    this.waitSeconds,
  );

  String toString() {
    return 'TgFloodWaiException: $waitSeconds';
  }
}

class TgMaxRetriesExcedeedException implements Exception {
  final int maxRetries;

  TgMaxRetriesExcedeedException(
    this.maxRetries,
  );

  String toString() {
    return 'TgMaxRetriesExcedeedException: $maxRetries';
  }
}

class TgTimeOutException implements Exception {
  final int millisenconds;
  final String request;

  TgTimeOutException(
    this.millisenconds,
    this.request,
  );

  String toString() {
    return 'TgTimeOutException: '
        'request $request timed out '
        'after ${millisenconds / 1000} seconds.';
  }
}

class TgDbException implements Exception {
  SqliteException? exception;
  String? operationName;
  TgDbException({this.exception, this.operationName});

  String toString() {
    var report = 'TgDbException';
    if (exception != null) {
      report += ': got $exception';
    }
    if (operationName != null) {
      report += ' in operation $operationName';
    }
    return report;
  }
}
