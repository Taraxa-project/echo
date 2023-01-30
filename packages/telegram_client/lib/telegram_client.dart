import 'dart:async';
import 'dart:isolate';

import 'package:logging/logging.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:td_json_client/td_json_client.dart';
import 'package:uuid/uuid.dart';
import 'package:telegram_client/wrap_id.dart';
import 'log.dart';
import 'db.dart';

class TelegramClient {
  late final ReceivePort _isolateReceivePort;
  late final Stream<dynamic> _isolateReceivePortBroadcast;
  late final SendPort isolateSendPort;

  late final Log _log;
  late final Db _db;

  final _logger = Logger('TelegramClient');
  final Level logLevelLibTdJson;

  bool _running = false;

  TelegramClient({
    required Level logLevel,
    required this.logLevelLibTdJson,
  }) {
    _logger.level = logLevel;
  }

  Future<void> spawn({
    required Log log,
    required Db db,
    required String libtdjsonlcPath,
    double tdReceiveWaitTimeout = 0.005,
    Duration tdReceiveFrequency = const Duration(milliseconds: 10),
  }) async {
    _running = true;

    _log = log;
    _db = db;

    _logger.onRecord.listen((event) {
      _log.isolateSendPort.send(event);
    });

    _isolateReceivePort = ReceivePort();
    _isolateReceivePortBroadcast = _isolateReceivePort.asBroadcastStream();

    _logger.fine('spawning TgIsolated...');
    await Isolate.spawn(
      TelegramClient._entryPoint,
      TgIsolatedSpwanMessage(
        parentSendPort: _isolateReceivePort.sendPort,
        logSendPort: _log.isolateSendPort,
        dbSendPort: _db.isolateSendPort,
        libtdjsonlcPath: libtdjsonlcPath,
        logLevel: _logger.level,
        logLevelLibtdjson: logLevelLibTdJson,
        tdReceiveWaitTimeout: tdReceiveWaitTimeout,
        tdReceiveFrequency: tdReceiveFrequency,
      ),
      debugName: runtimeType.toString(),
    );
    _logger.fine('spawned.');

    isolateSendPort = await _isolateReceivePortBroadcast.first;
  }

  static void _entryPoint(
    TgIsolatedSpwanMessage tgIsolatedSpwanMessage,
  ) {
    hierarchicalLoggingEnabled = true;

    final tgIsolated = TelegramClientIsolated(
      parentSendPort: tgIsolatedSpwanMessage.parentSendPort,
      logSendPort: tgIsolatedSpwanMessage.logSendPort,
      dbSendPort: tgIsolatedSpwanMessage.dbSendPort,
      libtdjsonlcPath: tgIsolatedSpwanMessage.libtdjsonlcPath,
      logLevel: tgIsolatedSpwanMessage.logLevel,
      logLevelLibtdjson: tgIsolatedSpwanMessage.logLevelLibtdjson,
      tdReceiveWaitTimeout: tgIsolatedSpwanMessage.tdReceiveWaitTimeout,
      tdReceiveFrequency: tgIsolatedSpwanMessage.tdReceiveFrequency,
    );
    tgIsolated.init();
  }

  Future<void> exit() async {
    if (!_running) return;

    isolateSendPort.send(TgMsgRequestExit(
      replySendPort: _isolateReceivePort.sendPort,
    ));
    await _isolateReceivePortBroadcast
        .firstWhere((element) => element is TgMsgResponseExit);

    _isolateReceivePort.close();

    _running = false;
  }

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
      replySendPort: _isolateReceivePort.sendPort,
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
    return await _isolateReceivePortBroadcast
        .firstWhere((element) => element is TgMsgResponseLogin)
        .onError(<StateError>(error, _) =>
            _logger.warning('readChatsHistory $error'));
  }

  Future<TgMsgResponseReadChatHistory> readChatsHistory({
    required DateTime dateTimeFrom,
    required List<String> chatsNames,
  }) async {
    isolateSendPort.send(TgMsgRequestReadChatsHistory(
      replySendPort: _isolateReceivePort.sendPort,
      dateTimeFrom: dateTimeFrom,
      chatsNames: chatsNames,
    ));

    TgMsgResponseReadChatHistory response = await _isolateReceivePortBroadcast
        .firstWhere((element) => element is TgMsgResponseReadChatHistory)
        .onError(<StateError>(error, _) =>
            _logger.warning('readChatsHistory $error'));
    if (response.exception != null) {
      _logger.severe("Exception happened while: ${response.operationName}");
     throw response.exception!;
    }
    return response;
  }
}

class TgIsolatedSpwanMessage {
  final SendPort parentSendPort;
  final SendPort logSendPort;
  final SendPort dbSendPort;
  final String libtdjsonlcPath;
  final Level logLevel;
  final Level logLevelLibtdjson;
  final double tdReceiveWaitTimeout;
  final Duration tdReceiveFrequency;

  TgIsolatedSpwanMessage({
    required this.parentSendPort,
    required this.logSendPort,
    required this.dbSendPort,
    required this.libtdjsonlcPath,
    required this.logLevel,
    required this.logLevelLibtdjson,
    required this.tdReceiveWaitTimeout,
    required this.tdReceiveFrequency,
  });
}

class TelegramClientIsolated {
  final _logger = Logger('TelegramClientIsolated');

  final SendPort parentSendPort;
  final SendPort logSendPort;
  final SendPort dbSendPort;

  late final ReceivePort receivePort;
  late final Stream<dynamic> receivePortBroadcast;

  final String libtdjsonlcPath;
  late final TdJsonClient _tdJsonClient;
  late final int _tdJsonClientId;

  late final StreamController _tdStreamController;

  double tdReceiveWaitTimeout = 0.005;
  Duration tdReceiveFrequency = Duration(milliseconds: 10);

  bool _isTdReceiving = false;
  Timer? receiveTimer;

  static const int tgRetryCountMax = 5;
  static const int tgTimeoutMilliseconds = 15 * 1000;
  static const int tgTimeoutDelayMilliseconds = 50;

  static const int delayUntilNextChatSeconds = 15;
  static const int delayUntilNextMessageBatchSeconds = 15;
  static const int delayUntilNextUserSeconds = 1;

  TelegramClientIsolated({
    required this.parentSendPort,
    required this.logSendPort,
    required this.dbSendPort,
    required this.libtdjsonlcPath,
    required Level logLevel,
    required Level logLevelLibtdjson,
    this.tdReceiveWaitTimeout = 0.005,
    this.tdReceiveFrequency = const Duration(milliseconds: 10),
  }) {
    _logger.level = logLevel;
    _logger.onRecord.listen((logRecord) {
      logSendPort.send(logRecord);
    });

    _logger.fine('initializing TdJsonClient...');

    _tdJsonClient = TdJsonClient(libtdjsonlcPath: libtdjsonlcPath);
    _tdJsonClientId = _tdJsonClient.create_client_id();

    final loggerTdJsonClient = Logger('TdJsonClient');
    loggerTdJsonClient.level = Level.ALL;
    loggerTdJsonClient.onRecord.listen((event) {
      logSendPort.send(event);
    });
    final loggerLibTdJson = Logger('LibTdJson');
    loggerLibTdJson.level = logLevelLibtdjson;
    loggerLibTdJson.onRecord.listen((event) {
      logSendPort.send(event);
    });
    _tdJsonClient.setupLogs(loggerTdJsonClient, loggerLibTdJson);

    _logger.fine('created client id $_tdJsonClientId.');
    _logger.fine('initialization finished.');

    _tdStreamController = StreamController.broadcast(
      onListen: _tdStart,
      onCancel: _tdStop,
    );
  }

  Future<void> init() async {
    _initPorts();
    _initDispatch();
  }

  void _initPorts() {
    receivePort = ReceivePort();
    receivePortBroadcast = receivePort.asBroadcastStream();

    parentSendPort.send(receivePort.sendPort);
  }

  void _initDispatch() {
    receivePortBroadcast.listen((message) async {
      if (message is TgMsgRequestExit) {
        _logger.fine('exiting...');
        await _exit(
          replySendPort: message.replySendPort,
        );
      } else if (message is TgMsgRequestLogin) {
        message.replySendPort?.send(
          await _login(
            apiId: message.apiId,
            apiHash: message.apiHash,
            phoneNumber: message.phoneNumber,
            databasePath: message.databasePath,
            readTelegramCode: message.readTelegramCode,
            writeQrCodeLink: message.writeQrCodeLink,
            readUserFirstName: message.readUserFirstName,
            readUserLastName: message.readUserLastName,
            readUserPassword: message.readUserPassword,
          ),
        );
      } else if (message is TgMsgRequestReadChatsHistory) {
        message.replySendPort?.send(
          await _readChatsHistory(
            datetimeFrom: message.dateTimeFrom,
            chatsNames: message.chatsNames,
          ),
        );
      }
    });
  }

  Future<void> _exit({SendPort? replySendPort}) async {
    _tdJsonClient.exit();
    await _tdStreamController.close();
    replySendPort?.send(TgMsgResponseExit());

    await Future.delayed(const Duration(milliseconds: 10));
    _logger.fine('closing tg isolate port');

    receivePort.close();
    Isolate.exit();
  }

  void _tdStart() {
    _logger.fine('starting the receive timer...');
    receiveTimer = Timer.periodic(tdReceiveFrequency, _tdReceive);
    _logger.fine('receive timer started.');
  }

  void _tdStop() {
    _logger.fine('stopping the receive timer...');
    receiveTimer?.cancel();
    receiveTimer = null;
    _logger.fine('receive timer stopped.');
  }

  void _tdReceive(Timer timer) {
    if (!_isTdReceiving) {
      _isTdReceiving = true;

      var event = _tdJsonClient.receive(waitTimeout: tdReceiveWaitTimeout);
      if (event != null) {
        _logger.finer('received ${event.runtimeType}.');
        _tdStreamController.add(event);
      }

      _isTdReceiving = false;
    }
  }

  void _tdSend(
    TdFunction tdFunction,
  ) {
    _logger.fine('sending ${tdFunction.runtimeType}...');
    _logger.finer('sending $tdFunction...');
    _tdJsonClient.send(_tdJsonClientId, tdFunction);
    _logger.fine('sent ${tdFunction.runtimeType}.');
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
      throw TgTimedOutException(
        elapsedMilliseconds,
        tdFunction.runtimeType.toString(),
      );
    } else if (tdResponse.runtimeType.toString() == tdFunction.tdReturnType) {
      return tdResponse;
    } else if (tdResponse is Error) {
      _handleTdError(tdResponse);
    } else {
      _logger.info('received invalid response type for '
          '${tdFunction.runtimeType.toString()}: '
          '${tdResponse.runtimeType}.');
      throw TgException('invalid response type ${tdResponse.runtimeType}');
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
        _logger.warning('received flood wait for '
            '${tdFunction.runtimeType.toString()}. '
            'Retrying in ${ex.waitSeconds} seconds.');
        await Future.delayed(Duration(seconds: ex.waitSeconds));
        continue;
      }
    }

    throw TgMaxRetriesExcedeedException(retryCountMax);
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
    _logger.info('logging in...');

    var extra = Uuid().v1();

    var isAuthorized = false;
    var isClosed = false;
    var isError = false;

    var sub = _tdStreamController.stream
        .where((event) => event.extra == extra)
        .listen(
      (event) {
        _logger.fine('login: received ${event.runtimeType}.');
        if (event is Error) {
          isError = true;
          _logger.warning('login: $event');
        } else if (event is AuthorizationState) {
          switch (event.runtimeType) {
            case AuthorizationStateWaitTdlibParameters:
              _tdSend(
                SetTdlibParameters(
                  api_id: apiId,
                  api_hash: apiHash,
                  database_directory: databasePath,
                  use_message_database: false,
                  device_model: 'Desktop',
                  application_version: '1.0',
                  system_language_code: 'en',
                  database_encryption_key: '',
                  extra: extra,
                ),
              );
              break;
            case AuthorizationStateWaitPhoneNumber:
              _tdSend(SetAuthenticationPhoneNumber(
                phone_number: phoneNumber,
                extra: extra,
              ));
              break;
            case AuthorizationStateWaitCode:
              _tdSend(CheckAuthenticationCode(
                code: readTelegramCode(),
                extra: extra,
              ));
              break;
            case AuthorizationStateWaitOtherDeviceConfirmation:
              writeQrCodeLink(
                  (event as AuthorizationStateWaitOtherDeviceConfirmation)
                          .link ??
                      '');
              break;
            case AuthorizationStateWaitRegistration:
              _tdSend(RegisterUser(
                first_name: readUserFirstName(),
                last_name: readUserLastName(),
                extra: extra,
              ));
              break;
            case AuthorizationStateWaitPassword:
              _tdSend(CheckAuthenticationPassword(
                password: readUserPassword(),
                extra: extra,
              ));
              break;
            case AuthorizationStateReady:
              isAuthorized = true;
              break;
            case AuthorizationStateLoggingOut:
              isClosed = true;
              break;
            case AuthorizationStateClosing:
              isClosed = true;
              break;
            case AuthorizationStateClosed:
              isClosed = true;
              break;
          }
        } else if (event is Ok) {
          isAuthorized = true;
        } else {
          _logger.warning('login: other: $event');
        }
      },
    );

    _tdSend(GetAuthorizationState(
      extra: extra,
    ));

    while (true) {
      if (isAuthorized) {
        _logger.info('login: success.');
        break;
      }
      if (isClosed) {
        _logger.info('login: closed.');
        break;
      }
      if (isError) {
        _logger.info('login: error.');
        break;
      }
      await Future.delayed(const Duration(milliseconds: 100));
    }

    sub.cancel();

    return TgMsgResponseLogin(
      isAuthorized: isAuthorized,
      isClosed: isClosed,
      isError: isError,
    );
  }

  Future<TgMsgResponseReadChatHistory> _readChatsHistory({
    required DateTime datetimeFrom,
    required List<String> chatsNames,
  }) async {
    _logger.info('reading chats history');
    await Future.delayed(const Duration(seconds: 30));
    return TgMsgResponseReadChatHistory();

    try {
      await _addChats(usernames: chatsNames);
    } on TgDbException catch (dbException) {
      return TgMsgResponseReadChatHistory(exception: dbException.exception, operationName: dbException.operationName);
    }

    _logger.info('reading chats history...');

    for (final chatName in chatsNames) {
      _logger.info('[$chatName] reading chat history...');

      try {
        await _readChatHistory(
          dateTimeFrom: datetimeFrom,
          chatName: chatName,
        );
      } on TgChatNotFoundException catch (ex) {
        _logger.warning('[$chatName] $ex.');
        try {
          await _blacklistChat(
          chatName: chatName,
          reason: ex.message ?? 'Chat not found.',
        );
        } on TgDbException catch (dbException) {
          _logger.severe('[$chatName] failed to blacklist chat $dbException.');
          return TgMsgResponseReadChatHistory(exception: dbException.exception, operationName: dbException.operationName);
        }
      } on TgTimedOutException catch (ex) {
        _logger.severe('[$chatName] $ex.');
      } on TgMaxRetriesExcedeedException catch (ex) {
        _logger.severe('[$chatName] $ex.');
      } on TgBadRequestException catch (ex) {
        _logger.severe('[$chatName] $ex.');
      } on UnWrapIdxception catch (ex) {
        _logger.severe('[$chatName] $ex.');
      } on TgErrorCodeNotHandledException catch (ex) {
        _logger.severe('[$chatName] $ex.');
      } on TgException catch (ex) {
        _logger.severe('[$chatName] $ex.');
      } on TgDbException catch (dbException) {
        return TgMsgResponseReadChatHistory(exception: dbException.exception, operationName: dbException.operationName);
      }

      _logger.info('[$chatName] reading chat history... done.');

      _logger.info('reading chats history... '
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
    _logger.info('[$chatName] unwrapped chat id is $chatId.');

    await _updateChat(
      chatName: chatName,
      chat: chat,
    );

    _logger.info('[$chatName] getting supergroup full info... ');
    final supergroupFullInfo = await _getSupergroupFullInfo(
      chatName: chatName,
      chatId: chatId,
    );
    if (supergroupFullInfo.member_count != null &&
        supergroupFullInfo.member_count != 0) {
      _logger.info('[$chatName] member count is '
          '${supergroupFullInfo.member_count}.');
      await _updateChatMembersCount(
        chatName: chatName,
        memberCount: supergroupFullInfo.member_count!,
      );
    }

    _logger.info('[$chatName] check online member count... ');
    final subscriptionUpdateChatOnlineMemberCount =
        _subscribeUpdateChatOnlineMemberCount(
      chatName: chatName,
      chatId: chatId,
    );

    _logger.info('[$chatName] opening chat... ');
    await _openChat(chatName: chatName, chatId: chatId);

    _logger.info('[$chatName] getting bot count... ');
    final chatMembersBots = await _getSupergroupMembers(
      chatName: chatName,
      chatId: chatId,
      supergroupMembersFilter: SupergroupMembersFilterBots(),
    );
    if (chatMembersBots.members != null) {
      _logger.info('[$chatName] bot count is '
          '${chatMembersBots.members!.length}.');
      await _updateChatMembersBotsCount(
        chatName: chatName,
        memberCount: chatMembersBots.members!.length,
      );
    }

    await subscriptionUpdateChatOnlineMemberCount.cancel();

    _logger.info('[$chatName] closing chat... ');
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
      _logger.info('[$chatName] reading messages from $messageIdFrom... ');

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

      _logger.info('[$chatName] reading messages... '
          'sleeping for $delayUntilNextChatSeconds seconds.');
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
      throw TgDbException(exception: response.exception, operationName: response.operationName);
    }
    _logger.fine('[$userId] added user to user table.');
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
            _logger.fine('[${userId}] already exists');
          } else {
            throw TgDbException(exception: response.exception, operationName: response.operationName);
          }
        } else {
          if (userCount == 0) {
            _logger.info('[$chatName] saving users...');
            _logger.info('[$chatName] getting users...');
          }
          _logger.fine('[$chatName] getting user $userId... ');
          var user = await _getUser(userId: userId);
          await _updateUser(userId: userId, user: user);
          userCount += 1;

          _logger.fine('[$chatName] getting user... '
              'sleeping for $delayUntilNextUserSeconds seconds.');
          await Future.delayed(
              const Duration(seconds: delayUntilNextUserSeconds));
        }
      }
    }

    if (userCount > 0) {
      _logger.info('[$chatName] saved $userCount users.');
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
    final chat = await _retryTdCall(
      tdFunction: SearchPublicChat(
        username: chatName,
      ),
      timeoutMilliseconds: timeoutMilliseconds,
      retryCountMax: retryCountMax,
    ) as Chat;

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
    _logger.info('[$chatName] searching last message by date...');

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

    _logger.info('[$chatName] searching last message by date... done.');

    return messageIdLast;
  }

  Future<int?> _searchMessageIdLastRemote({
    required String chatName,
    required int chatId,
    required DateTime datetimeFrom,
    int timeoutMilliseconds = tgTimeoutMilliseconds,
    int retryCountMax = tgRetryCountMax,
  }) async {
    _logger.info('[$chatName] searching last message id remote...');

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
      _logger.info('[$chatName] searching last message id remote... '
          'found $messageIdLast.');
    } on TgNotFoundException {
      _logger.info('[$chatName] searching last message id remote... '
          'not found.');
    } on UnWrapIdxception {
      _logger.info('[$chatName] searching last message id remote... '
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
          _logger.info('[$chatName] online member count is '
              '${updateChatOnlineMemberCount.online_member_count}.');
          _updateChatMembersOnlineCount(
              chatName: chatName,
              memberCount: updateChatOnlineMemberCount.online_member_count!);
        }
      }
    });
  }

  Future<void> _addChats({
    required List<String> usernames,
  }) async {
    _logger.info('adding chats to db...');

    dbSendPort.send(DbMsgRequestAddChats(
      replySendPort: receivePort.sendPort,
      usernames: usernames,
    ));
    var response = await receivePortBroadcast
        .where((event) => event is DbMsgResponseAddChats)
        .first;

    if (response.exception != null) {
      throw TgDbException(exception: response.exception, operationName: response.operationName);
    }

    _logger.info('added ${usernames.length} chats to db...');
  }

  Future<void> _updateChat({
    required String chatName,
    required Chat chat,
  }) async {
    _logger.info('[$chatName] updating chat in db...');

    dbSendPort.send(DbMsgRequestUpdateChat(
      replySendPort: receivePort.sendPort,
      username: chatName,
      chat: chat,
    ));
    var response = await receivePortBroadcast
        .where((event) => event is DbMsgResponseUpdateChat)
        .first;

    if (response.exception != null) {
      throw TgDbException(exception: response.exception, operationName: response.operationName);
    }
    _logger.info('[$chatName] updating chat in db... done.');
  }

  Future<void> _updateChatMembersCount({
    required String chatName,
    required int memberCount,
  }) async {
    _logger.info('[$chatName] updating chat member count in db...');

    dbSendPort.send(DbMsgRequestUpdateChatMembersCount(
      replySendPort: receivePort.sendPort,
      username: chatName,
      membersCount: memberCount,
    ));
    var response = await receivePortBroadcast
        .where((event) => event is DbMsgResponseUpdateChatMembersCount)
        .first;

    if (response.exception != null) {
      throw TgDbException(exception: response.exception, operationName: response.operationName);
    } else {
      _logger.info('[$chatName] updating chat member count in db... done.');
    }  
  }

  Future<void> _updateChatMembersBotsCount({
    required String chatName,
    required int memberCount,
  }) async {
    _logger.info('[$chatName] updating chat bot count in db...');

    dbSendPort.send(DbMsgRequestUpdateChatMembersBotsCount(
      replySendPort: receivePort.sendPort,
      username: chatName,
      membersCount: memberCount,
    ));
    var response = await receivePortBroadcast
        .where((event) => event is DbMsgResponseUpdateChatMembersBotsCount)
        .first;
    
    if (response.exception != null) {
      throw TgDbException(exception: response.exception, operationName: response.operationName);
    } else {
      _logger.info('[$chatName] updating chat bot count in db... done.');
    }
  }

  Future<void> _updateChatMembersOnlineCount({
    required String chatName,
    required int memberCount,
  }) async {
    _logger.info('[$chatName] updating chat online member count in db...');

    dbSendPort.send(DbMsgRequestUpdateChatMembersOnlineCount(
      replySendPort: receivePort.sendPort,
      username: chatName,
      membersCount: memberCount,
    ));
    await receivePortBroadcast
        .where((event) => event is DbMsgResponseUpdateChatMembersOnlineCount)
        .first;

    _logger
        .info('[$chatName] updating chat online member count in db... done.');
  }

  Future<void> _blacklistChat({
    required String chatName,
    required String reason,
  }) async {
    _logger.info('[$chatName] blacklisting chat in db... '
        'Reason: $reason.');

    dbSendPort.send(DbMsgRequestBlacklistChat(
      replySendPort: receivePort.sendPort,
      username: chatName,
      reason: reason,
    ));
    var response = await receivePortBroadcast
        .where((event) => event is DbMsgResponseBlacklistChat)
        .first;
      
    if (response.exception != null){
      throw TgDbException(exception: response.exception, operationName: response.operationName);
    } else{
    _logger.info('[$chatName] blacklisting chat in db... done.');
    }
  }

  Future<int?> _saveMessages({
    required String chatName,
    required int chatId,
    required Messages messages,
    required int? onlineMemberCount,
  }) async {
    _logger.info('[$chatName] saving messages...');

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
        throw TgDbException(exception: response.exception, operationName: response.operationName);
      } 

      messageCount += 1;

      int messageId;
      try {
        messageId = WrapId.unwrapMessageId(message.id);
      } on UnWrapIdxception catch (ex) {
        _logger.severe(ex);
        continue;
      }

      if (messageIdLast == null) {
        messageIdLast = messageId;
      } else if (messageId > messageIdLast) {
        messageIdLast = messageId;
      }
    }

    _logger.info('[$chatName] saved ${messageCount} messages.');

    return messageIdLast;
  }

  Future<int?> _searchMessageIdLastLocally({
    required DateTime dateTimeFrom,
    required String chatName,
    required int chatId,
  }) async {
    _logger.info('[$chatName] searching last message id locally...');

    dbSendPort.send(DbMsgRequestSelectMaxMessageId(
      replySendPort: receivePort.sendPort,
      chatId: chatId,
      dateTimeFrom: dateTimeFrom,
    ));
    var response = await receivePortBroadcast
        .where((event) => event is DbMsgResponseSelectMaxMessageId)
        .first;

    if (response.exception != null) {
      _logger.info('[_searchMessageIdLastLocally] db error occured');
      throw TgDbException(exception: response.exception, operationName: response.operationName);
    }
    else if (response.id == null) {
      _logger.info('[$chatName] searching last message id locally... '
          'not found.');
    } else {
      _logger.info('[$chatName] searching last message id locally... '
          'found ${response.id}.');
    }

    _logger.info('[$chatName] searching last message id locally... done.');

    return response.id;
  }

  Future<int?> _selectOnlineMemberCount({
    required String chatName,
  }) async {
    _logger.info('[$chatName] selecting online member count locally...');

    dbSendPort.send(DbMsgRequestSelectChatOnlineMemberCount(
      replySendPort: receivePort.sendPort,
      chatName: chatName,
    ));
    var response = await receivePortBroadcast
        .where((event) => event is DbMsgResponseSelectChatOnlineMemberCount)
        .first as DbMsgResponseSelectChatOnlineMemberCount;

    if (response.exception != null) {
      _logger.info('[_selectOnlineMemberCount] db error occured');
      throw TgDbException(exception: response.exception, operationName: response.operationName);
    } else if (response.onlineMemberCount == null) {
      _logger.info('[$chatName] searching online member count locally... '
          'not found.');
    } else {
      _logger.info('[$chatName] searching online member count locally... '
          'found ${response.onlineMemberCount}.');
    }

    _logger.info('[$chatName] searching online member count locally... done.');

    return response.onlineMemberCount;
  }

  int? _parseFloodWaitSeconds({String? floodWaitMessage}) {
    return int.tryParse(
        floodWaitMessage?.replaceFirst('FLOOD_WAIT_', '') ?? '');
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
    } else if (error.code == 402) {
      var floodWaitSeconds =
          _parseFloodWaitSeconds(floodWaitMessage: error.message);
      if (floodWaitSeconds == null) {
        throw TgException('could not parse flood wait seconds: '
            '${error.message}');
      } else {
        throw TgFloodWaiException(floodWaitSeconds);
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

abstract class TgMsg {}

abstract class TgMsgRequest extends TgMsg {
  final SendPort? replySendPort;
  TgMsgRequest({
    this.replySendPort,
  });
}

abstract class TgMsgResponse extends TgMsg {
  final SqliteException? exception;
  final String? operationName;
  TgMsgResponse({
    this.exception,
    this.operationName
  });
}

class TgMsgRequestExit extends TgMsgRequest {
  TgMsgRequestExit({
    super.replySendPort,
  });
}

class TgMsgResponseExit extends TgMsgResponse {}

class TgMsgRequestLogin extends TgMsgRequest {
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
  bool isClosed = false;
  bool isError = false;

  TgMsgResponseLogin({
    required this.isAuthorized,
    required this.isClosed,
    required this.isError,
  });
}

class TgMsgRequestReadChatsHistory extends TgMsgRequest {
  final DateTime dateTimeFrom;
  final List<string> chatsNames;

  TgMsgRequestReadChatsHistory({
    super.replySendPort,
    required this.dateTimeFrom,
    required this.chatsNames,
  });
}

class TgMsgResponseReadChatHistory extends TgMsgResponse {
  TgMsgResponseReadChatHistory({super.exception, super.operationName});
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

class TgTimedOutException implements Exception {
  final int millisenconds;
  final String request;

  TgTimedOutException(
    this.millisenconds,
    this.request,
  );

  String toString() {
    return 'TgTimedOutException: '
        'request $request timed out '
        'after ${millisenconds / 1000} seconds.';
  }
}

class TgDbException {
  SqliteException? exception;
  String? operationName;
  TgDbException({this.exception, this.operationName});
}
