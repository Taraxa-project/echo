import 'dart:async';
import 'dart:isolate';

import 'package:logging/logging.dart';
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
    isolateSendPort.send(TgMsgRequestExit(
      replySendPort: _isolateReceivePort.sendPort,
    ));
    await _isolateReceivePortBroadcast
        .where((event) => event is TgMsgResponseExit)
        .first;
    _isolateReceivePort.close();
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
        .where((event) => event is TgMsgResponseLogin)
        .first;
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
        .where((event) => event is TgMsgResponseReadChatHistory)
        .first;
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

  static const int retryCountMax = 5;
  static const int delaySecondsSearchPublicChat = 15;

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
    receivePortBroadcast.listen((message) {
      if (message is TgMsgRequestExit) {
        _logger.fine('exiting...');
        _exit(
          replySendPort: message.replySendPort,
        );
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

  Future<void> _exit({SendPort? replySendPort}) async {
    _tdJsonClient.exit();
    await _tdStreamController.close();

    replySendPort?.send(TgMsgResponseExit());

    await Future.delayed(const Duration(milliseconds: 10));

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
    await _addChats(usernames: chatsNames);

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
        await _blacklistChat(
          chatName: chatName,
          reason: ex.message ?? 'Chat not found.',
        );
      } on TgBadRequestException catch (ex) {
        _logger.severe('[$chatName] $ex.');
      } on UnWrapIdxception catch (ex) {
        _logger.severe('[$chatName] $ex.');
      } on TgFloodWaitMaxRetriesExceededException catch (ex) {
        _logger.severe('[$chatName] $ex.');
      } on TgException catch (ex) {
        _logger.severe('[$chatName] $ex.');
      }

      _logger.info('[$chatName] reading chat history... done.');

      _logger.info('reading chat history... '
          'Sleeping for $delaySecondsSearchPublicChat seconds.');
      await Future.delayed(const Duration(
        seconds: delaySecondsSearchPublicChat,
      ));
    }

    return TgMsgResponseReadChatHistory();
  }

  Future<void> _readChatHistory({
    required DateTime dateTimeFrom,
    required String chatName,
  }) async {
    final chat = await _retrySearchPublicChat(chatName: chatName);

    final chatId = WrapId.unwrapChatId(chat.id);
    _logger.info('[$chatName] unwrapped chat id is $chatId.');

    await _updateChat(
      chatName: chatName,
      chat: chat,
    );

    final supergroupFullInfo = await _retryGetSupergroupFullInfo(
      chatName: chatName,
      chatId: chatId,
    );
    if (supergroupFullInfo.member_count != null &&
        supergroupFullInfo.member_count != 0) {
      _logger.info('[$chatName] member count is '
          'is ${supergroupFullInfo.member_count}.');
      await _updateChatMembersCount(
        chatName: chatName,
        memberCount: supergroupFullInfo.member_count!,
      );
    }

    final subscriptionUpdateChatOnlineMemberCount =
        _subscribeUpdateChatOnlineMemberCount(
      chatName: chatName,
      chatId: chatId,
    );

    await _retryOpenChat(chatName: chatName, chatId: chatId);

    final chatMembersBots = await _retryGetSupergroupMembers(
      chatName: chatName,
      chatId: chatId,
      supergroupMembersFilter: SupergroupMembersFilterBots(),
    );
    if (chatMembersBots.members != null) {
      _logger.info('[$chatName] bot count is '
          'is ${chatMembersBots.members!.length}.');
      await _updateChatMembersBotsCount(
        chatName: chatName,
        memberCount: chatMembersBots.members!.length,
      );
    }

    await subscriptionUpdateChatOnlineMemberCount.cancel();

    await _retryCloseChat(chatName: chatName, chatId: chatId);

    var messsageIdLast = await _searchMessageIdLast(
      datetimeFrom: dateTimeFrom,
      chatName: chatName,
      chatId: chatId,
    );
    if (messsageIdLast == null) {
      messsageIdLast = 0;
    }

    while (true) {
      var messageIdFrom = messsageIdLast! + 1;

      var messages = await _getChatHistory(
        chatName: chatName,
        chatId: chatId,
        messageIdFrom: messageIdFrom,
      );

      if (messages == null ||
          messages.messages == null ||
          messages.messages?.length == 0) {
        break;
      }

      messsageIdLast = await _saveMessages(
        chatName: chatName,
        chatId: chatId,
        messages: messages,
      );

      if (messsageIdLast == null) {
        break;
      }
    }
  }

  Future<Chat> _retrySearchPublicChat({
    int retryCountMax = retryCountMax,
    required String chatName,
  }) async {
    var retryCountIndex = 0;
    while (retryCountIndex < retryCountMax) {
      retryCountIndex += 1;

      _logger.info('[$chatName] searching public chat... '
          'Retry [$retryCountIndex/$retryCountMax].');

      final tdResponse = await _searchPublicChat(chatName: chatName);

      if (tdResponse is Chat) {
        _logger.info('[$chatName] received Chat. '
            'Retry [$retryCountIndex/$retryCountMax].');

        if (tdResponse.id == null) {
          throw TgChatNotFoundException('Chat.id is null');
        } else if (tdResponse.type == null) {
          throw TgChatNotFoundException('Chat.type is null');
        } else if (!(tdResponse.type is ChatTypeSupergroup)) {
          throw TgChatNotFoundException('Invalid Chat.type: '
              '${tdResponse.type.runtimeType}');
        }
        return tdResponse;
      } else if (tdResponse is Error) {
        _logger.info('[$chatName] received Error. '
            'Retry [$retryCountIndex/$retryCountMax].');

        try {
          _handleTdError(tdResponse);
        } on TgFloodWaiException catch (ex) {
          _logger.warning('[$chatName] retrying in ${ex.waitSeconds} seconds.');
          await Future.delayed(Duration(seconds: ex.waitSeconds));
          continue;
        }
      } else {
        _logger.info('[$chatName] received ${tdResponse.runtimeType}. '
            'Retry [$retryCountIndex/$retryCountMax].');

        throw TgException('invalid response type ${tdResponse.runtimeType}');
      }
    }

    throw TgFloodWaitMaxRetriesExceededException(retryCountMax);
  }

  Future<dynamic> _searchPublicChat({
    required String chatName,
  }) async {
    var extra = Uuid().v1();
    _tdSend(SearchPublicChat(
      username: chatName,
      extra: extra,
    ));

    return await _tdStreamController.stream
        .where((event) => event.extra == extra)
        .first;
  }

  Future<Ok> _retryOpenChat({
    int retryCountMax = retryCountMax,
    required String chatName,
    required int chatId,
  }) async {
    var retryCountIndex = 0;
    while (retryCountIndex < retryCountMax) {
      retryCountIndex += 1;

      _logger.info('[$chatName] opening chat... '
          'Retry [$retryCountIndex/$retryCountMax].');

      final tdResponse = await _openChat(chatId: chatId);

      if (tdResponse is Ok) {
        _logger.info('[$chatName] received Ok. '
            'Retry [$retryCountIndex/$retryCountMax].');

        return tdResponse;
      } else if (tdResponse is Error) {
        _logger.info('[$chatName] received Error. '
            'Retry [$retryCountIndex/$retryCountMax].');

        try {
          _handleTdError(tdResponse);
        } on TgFloodWaiException catch (ex) {
          _logger.warning('[$chatName] retrying in ${ex.waitSeconds} seconds.');
          await Future.delayed(Duration(seconds: ex.waitSeconds));
          continue;
        }
      } else {
        _logger.info('[$chatName] received ${tdResponse.runtimeType}. '
            'Retry [$retryCountIndex/$retryCountMax].');

        throw TgException('invalid response type ${tdResponse.runtimeType}');
      }
    }

    throw TgFloodWaitMaxRetriesExceededException(retryCountMax);
  }

  Future<dynamic> _openChat({
    required int chatId,
  }) async {
    var extra = Uuid().v1();
    _tdSend(OpenChat(
      chat_id: WrapId.wrapChatId(chatId),
      extra: extra,
    ));

    return await _tdStreamController.stream
        .where((event) => event.extra == extra)
        .first;
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
              'is ${updateChatOnlineMemberCount.online_member_count}.');
          _updateChatMembersOnlineCount(
              chatName: chatName,
              memberCount: updateChatOnlineMemberCount.online_member_count!);
        }
      }
    });
  }

  Future<Ok> _retryCloseChat({
    int retryCountMax = retryCountMax,
    required String chatName,
    required int chatId,
  }) async {
    var retryCountIndex = 0;
    while (retryCountIndex < retryCountMax) {
      retryCountIndex += 1;

      _logger.info('[$chatName] closing chat... '
          'Retry [$retryCountIndex/$retryCountMax].');

      final tdResponse = await _closeChat(chatId: chatId);

      if (tdResponse is Ok) {
        _logger.info('[$chatName] received Chat. '
            'Retry [$retryCountIndex/$retryCountMax].');

        return tdResponse;
      } else if (tdResponse is Error) {
        _logger.info('[$chatName] received Error. '
            'Retry [$retryCountIndex/$retryCountMax].');

        try {
          _handleTdError(tdResponse);
        } on TgFloodWaiException catch (ex) {
          _logger.warning('[$chatName] retrying in ${ex.waitSeconds} seconds.');
          await Future.delayed(Duration(seconds: ex.waitSeconds));
          continue;
        }
      } else {
        _logger.info('[$chatName] received ${tdResponse.runtimeType}. '
            'Retry [$retryCountIndex/$retryCountMax].');

        throw TgException('invalid response type ${tdResponse.runtimeType}');
      }
    }

    throw TgFloodWaitMaxRetriesExceededException(retryCountMax);
  }

  Future<dynamic> _closeChat({
    required int chatId,
  }) async {
    var extra = Uuid().v1();
    _tdSend(CloseChat(
      chat_id: WrapId.wrapChatId(chatId),
      extra: extra,
    ));

    return await _tdStreamController.stream
        .where((event) => event.extra == extra)
        .first;
  }

  Future<SupergroupFullInfo> _retryGetSupergroupFullInfo({
    int retryCountMax = retryCountMax,
    required String chatName,
    required int chatId,
  }) async {
    var retryCountIndex = 0;
    while (retryCountIndex < retryCountMax) {
      retryCountIndex += 1;

      _logger.info('[$chatName] getting supergroup full info... '
          'Retry [$retryCountIndex/$retryCountMax].');

      final tdResponse = await _getSupergroupFullInfo(chatId: chatId);

      if (tdResponse is SupergroupFullInfo) {
        _logger.info('[$chatName] received SupergroupFullInfo. '
            'Retry [$retryCountIndex/$retryCountMax].');

        return tdResponse;
      } else if (tdResponse is Error) {
        _logger.info('[$chatName] received Error. '
            'Retry [$retryCountIndex/$retryCountMax].');

        try {
          _handleTdError(tdResponse);
        } on TgFloodWaiException catch (ex) {
          _logger.warning('[$chatName] retrying in ${ex.waitSeconds} seconds.');
          await Future.delayed(Duration(seconds: ex.waitSeconds));
          continue;
        }
      } else {
        _logger.info('[$chatName] received ${tdResponse.runtimeType}. '
            'Retry [$retryCountIndex/$retryCountMax].');

        throw TgException('invalid response type ${tdResponse.runtimeType}');
      }
    }

    throw TgFloodWaitMaxRetriesExceededException(retryCountMax);
  }

  Future<dynamic> _getSupergroupFullInfo({
    required int chatId,
  }) async {
    var extra = Uuid().v1();
    _tdSend(GetSupergroupFullInfo(
      supergroup_id: chatId,
      extra: extra,
    ));

    return await _tdStreamController.stream
        .where((event) => event.extra == extra)
        .first;
  }

  Future<ChatMembers> _retryGetSupergroupMembers({
    int retryCountMax = retryCountMax,
    required String chatName,
    required int chatId,
    SupergroupMembersFilter? supergroupMembersFilter,
  }) async {
    var retryCountIndex = 0;
    while (retryCountIndex < retryCountMax) {
      retryCountIndex += 1;

      _logger.info('[$chatName] getting supergroup members info... '
          'Retry [$retryCountIndex/$retryCountMax].');

      final tdResponse = await _getSupergroupMembers(
        chatId: chatId,
        supergroupMembersFilter: supergroupMembersFilter,
      );

      if (tdResponse is ChatMembers) {
        _logger.info('[$chatName] received ChatMembers. '
            'Retry [$retryCountIndex/$retryCountMax].');

        return tdResponse;
      } else if (tdResponse is Error) {
        _logger.info('[$chatName] received Error. '
            'Retry [$retryCountIndex/$retryCountMax].');

        try {
          _handleTdError(tdResponse);
        } on TgFloodWaiException catch (ex) {
          _logger.warning('[$chatName] retrying in ${ex.waitSeconds} seconds.');
          await Future.delayed(Duration(seconds: ex.waitSeconds));
          continue;
        }
      } else {
        _logger.info('[$chatName] received ${tdResponse.runtimeType}. '
            'Retry [$retryCountIndex/$retryCountMax].');

        throw TgException('invalid response type ${tdResponse.runtimeType}');
      }
    }

    throw TgFloodWaitMaxRetriesExceededException(retryCountMax);
  }

  Future<dynamic> _getSupergroupMembers({
    required int chatId,
    SupergroupMembersFilter? supergroupMembersFilter,
  }) async {
    var extra = Uuid().v1();
    _tdSend(GetSupergroupMembers(
      supergroup_id: chatId,
      filter: supergroupMembersFilter,
      offset: 0,
      limit: 200,
      extra: extra,
    ));

    return await _tdStreamController.stream
        .where((event) => event.extra == extra)
        .first;
  }

  Future<int?> _searchMessageIdLast({
    required DateTime datetimeFrom,
    required String chatName,
    required int chatId,
  }) async {
    _logger.info('[$chatName] searching last message by date...');

    var messageIdLast;

    messageIdLast = await _searchMessageIdLastLocally(
      dateTimeFrom: datetimeFrom,
      chatName: chatName,
      chatId: chatId,
    );

    if (messageIdLast == null) {
      messageIdLast = await _getChatMessageByDate(
        datetimeFrom: datetimeFrom,
        chatName: chatName,
        chatId: chatId,
      );
    }

    _logger.info('[$chatName] searching last message by date... done.');

    return messageIdLast;
  }

  Future<int?> _getChatMessageByDate({
    required DateTime datetimeFrom,
    required String chatName,
    required int chatId,
  }) async {
    _logger.info('[$chatName] reading last message '
        'before ${datetimeFrom.toIso8601String()} from TG...');

    var extra = Uuid().v1();
    _tdSend(GetChatMessageByDate(
      chat_id: WrapId.wrapChatId(chatId),
      date: datetimeFrom.millisecondsSinceEpoch ~/ 1000,
      extra: extra,
    ));

    var response = await _tdStreamController.stream
        .where((event) => event.extra == extra)
        .first;

    var messageId;

    if (response is Error) {
      _logger.warning('[$chatName] reading last message by date from TG'
          'failed with error.');
      _logger.warning('[$chatName] $response.');
    } else if (response is Message) {
      if (response.id != null) {
        _logger.info('[$chatName] found message id ${response.id}.');
        messageId = WrapId.unwrapMessageId(response.id);
        _logger.info('[$chatName] unwrapped message id is $messageId.');
      } else {
        _logger.warning('[$chatName] reading last message by date from TG '
            'failed with no message id.');
        _logger.warning('[$chatName] $response.');
      }
    }

    _logger.info('[$chatName] reading last message by date from TG... done.');

    return messageId;
  }

  Future<Messages?> _getChatHistory({
    required String chatName,
    required int chatId,
    required int messageIdFrom,
  }) async {
    _logger.info('[$chatName] getting chat history from $messageIdFrom...');

    var extra = Uuid().v1();
    _tdSend(GetChatHistory(
      chat_id: WrapId.wrapChatId(chatId),
      from_message_id: WrapId.wrapMessageId(messageIdFrom),
      offset: -99,
      limit: 99,
      only_local: false,
      extra: extra,
    ));

    var response = await _tdStreamController.stream
        .where((event) => event.extra == extra)
        .first;

    if (response is Error) {
      _logger.warning('[$chatName] getting chat history '
          'failed with error.');
      _logger.warning('[$chatName] $response.');
    }

    _logger
        .info('[$chatName] getting chat history from $messageIdFrom... done.');

    return response;
  }

  Future<void> _addChats({
    required List<String> usernames,
  }) async {
    _logger.info('adding chats to db...');

    dbSendPort.send(DbMsgRequestAddChats(
      replySendPort: receivePort.sendPort,
      usernames: usernames,
    ));
    await receivePortBroadcast
        .where((event) => event is DbMsgResponseAddChats)
        .first;

    _logger.info('adding chats to db... done.');
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
    await receivePortBroadcast
        .where((event) => event is DbMsgResponseUpdateChat)
        .first;

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
    await receivePortBroadcast
        .where((event) => event is DbMsgResponseUpdateChatMembersCount)
        .first;

    _logger.info('[$chatName] updating chat member count in db... done.');
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
    await receivePortBroadcast
        .where((event) => event is DbMsgResponseUpdateChatMembersBotsCount)
        .first;

    _logger.info('[$chatName] updating chat bot count in db... done.');
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
    await receivePortBroadcast
        .where((event) => event is DbMsgResponseBlacklistChat)
        .first;

    _logger.info('[$chatName] blacklisting chat in db... done.');
  }

  Future<int?> _saveMessages({
    required String chatName,
    required int chatId,
    required Messages messages,
  }) async {
    _logger.info('[$chatName] saving messages...');

    var messageCount = 0;

    var messageIdLast;

    for (Message message in messages.messages!) {
      dbSendPort.send(DbMsgRequestAddMessage(
        replySendPort: receivePort.sendPort,
        message: message,
      ));
      var response = await receivePortBroadcast
          .where((event) => event is DbMsgResponseAddMessage)
          .first;

      if (response.added) {
        messageCount += 1;
      }

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

    if (response.id == null) {
      _logger.info('[$chatName] searching last message id locally... '
          'not found.');
    } else {
      _logger.info('[$chatName] searching last message id locally... '
          'found ${response.id}.');
    }

    _logger.info('[$chatName] searching last message id locally... done.');

    return response.id;
  }

  int? _parseFloodWaitSeconds({String? floodWaitMessage}) {
    return int.tryParse(
        floodWaitMessage?.replaceFirst('FLOOD_WAIT_', '') ?? '');
  }

  void _handleTdError(Error error) {
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
    } else if (error.code == 406) {
      throw TgNotExceptableException(
        'Handle me: '
        'https://core.telegram.org/api/errors#406-not-acceptable',
        error.code,
      );
    } else {
      throw TgInternalException(
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

abstract class TgMsgResponse extends TgMsg {}

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

class TgMsgResponseReadChatHistory extends TgMsgResponse {}

class TgException implements Exception {
  final String? message;

  TgException([this.message = '']);

  String toString() {
    var report = "TgException";
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
    var report = "TgChatNotFoundException";
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
    var report = "TgBadRequestException";
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
    var report = "TgNotExceptableException";
    if (message != null) {
      report += ': $message';
    }
    if (code != null) {
      report += ', code: $code';
    }
    return report;
  }
}

class TgInternalException implements Exception {
  final String? message;
  final int? code;

  TgInternalException([
    this.message = '',
    this.code = 0,
  ]);

  String toString() {
    var report = "TgInternalException";
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
    return "TgFloodWaiException: $waitSeconds";
  }
}

class TgFloodWaitMaxRetriesExceededException implements Exception {
  final int maxRetries;

  TgFloodWaitMaxRetriesExceededException(
    this.maxRetries,
  );

  String toString() {
    return "TgMaxRetriesExcedeedException: $maxRetries";
  }
}
