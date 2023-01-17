import 'dart:async';
import 'dart:isolate';

import 'package:logging/logging.dart';
import 'package:td_json_client/td_json_client.dart';
import 'package:uuid/uuid.dart';
import 'package:telegram_client/wrap_id.dart';

import 'lg.dart';
import 'db.dart';

class Tg {
  late final ReceivePort _isolateReceivePort;
  late final Stream<dynamic> _isolateReceivePortBroadcast;
  late final SendPort _isolateSendPort;

  late final Lg _lg;
  late final Db _db;

  final _logger = Logger('Tg');

  Future<void> spawn({
    required Lg lg,
    required Db db,
    required String libtdjsonlcPath,
    double tdReceiveWaitTimeout = 0.005,
    Duration tdReceiveFrequency = const Duration(milliseconds: 10),
  }) async {
    _lg = lg;
    _db = db;

    _logger.onRecord.listen((event) {
      _lg.isolateSendPort.send(event);
    });

    _isolateReceivePort = ReceivePort();
    _isolateReceivePortBroadcast = _isolateReceivePort.asBroadcastStream();
    _isolateReceivePortBroadcast
        .where((event) => event is LogRecord)
        .listen((logRecord) {
      _lg.isolateSendPort.send(logRecord);
    });

    _logger.fine('spawning TgIsolated...');
    await Isolate.spawn(
      Tg._entryPoint,
      [
        _isolateReceivePort.sendPort,
        _db.isolateSendPort,
        libtdjsonlcPath,
        tdReceiveWaitTimeout,
        tdReceiveFrequency,
      ],
      debugName: runtimeType.toString(),
    );

    _isolateSendPort = await _isolateReceivePortBroadcast.first;
  }

  static void _entryPoint(dynamic initialSpawnMessage) {
    final SendPort parentSendPort = initialSpawnMessage[0];
    final SendPort dbIsolateSendPort = initialSpawnMessage[1];
    final String libtdjsonlcPath = initialSpawnMessage[2];
    final double tdReceiveWaitTimeout = initialSpawnMessage[3];
    final Duration tdReceiveFrequency = initialSpawnMessage[4];

    var receivePort = ReceivePort();
    parentSendPort.send(receivePort.sendPort);
    dbIsolateSendPort.send(receivePort.sendPort); // send this port to dbIsolate to communicate back

    final tgIsolated = TgIsolated(
      parentSendPort: parentSendPort,
      dbIsolateSendPort: dbIsolateSendPort,
      libtdjsonlcPath: libtdjsonlcPath,
      tdReceiveWaitTimeout: tdReceiveWaitTimeout,
      tdReceiveFrequency: tdReceiveFrequency,
    );

    receivePort.listen((message) {
      if (message is TgMsgRequestExit) {
        tgIsolated._logger.fine('exiting...');
        tgIsolated.exit();
        receivePort.close();
        Isolate.exit();
      } else if (message is TgMsgRequestLogin) {
        tgIsolated
            .login(
              apiId: message.apiId,
              apiHash: message.apiHash,
              phoneNumber: message.phoneNumber,
              databasePath: message.databasePath,
              readTelegramCode: message.readTelegramCode,
              writeQrCodeLink: message.writeQrCodeLink,
              readUserFirstName: message.readUserFirstName,
              readUserLastName: message.readUserLastName,
              readUserPassword: message.readUserPassword,
            )
            .then((value) => parentSendPort.send(value));
      } else if (message is TgMsgRequestReadChatsHistory) {
        tgIsolated
            .readChatsHistory(
              datetimeFrom: message.datetimeFrom,
              chatsNames: message.chatsNames,
            )
            .then((value) => parentSendPort.send(value));
      }
    });

    tgIsolated._logger.fine('spawned.');
  }

  Future<void> exit() async {
    _isolateSendPort.send(TgMsgRequestExit());
    await Future.delayed(const Duration(milliseconds: 1000));
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
    _isolateSendPort.send(TgMsgRequestLogin(
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
    required DateTime datetimeFrom,
    required List<String> chatsNames,
  }) async {
    _isolateSendPort.send(TgMsgRequestReadChatsHistory(
      datetimeFrom: datetimeFrom,
      chatsNames: chatsNames,
    ));
    return await _isolateReceivePortBroadcast
        .where((event) => event is TgMsgResponseReadChatHistory)
        .first;
  }
}

class TgIsolated {
  final _logger = Logger('TgIsolated');

  final SendPort parentSendPort;

  final String libtdjsonlcPath;
  late final TdJsonClient _tdJsonClient;
  late final int _tdJsonClientId;

  late final StreamController _tdStreamController;

  double tdReceiveWaitTimeout = 0.005;
  Duration tdReceiveFrequency = Duration(milliseconds: 10);

  bool _isTdReceiving = false;
  Timer? receiveTimer;

  late final SendPort dbIsolateSendPort;

  TgIsolated({
    required this.parentSendPort,
    required this.libtdjsonlcPath,
    required this.dbIsolateSendPort,
    this.tdReceiveWaitTimeout = 0.005,
    this.tdReceiveFrequency = const Duration(milliseconds: 10),
    
  }) {
    _logger.onRecord.listen((logRecord) {
      parentSendPort.send(logRecord);
    });

    _logger.fine('initializing TdJsonClient...');

    _tdJsonClient = TdJsonClient(libtdjsonlcPath: libtdjsonlcPath);
    _tdJsonClientId = _tdJsonClient.create_client_id();

    _logger.fine('created client id $_tdJsonClientId.');
    _logger.fine('initialization finished.');

    _tdStreamController = StreamController.broadcast(
      onListen: _tdStart,
      onCancel: _tdStop,
    );
  }

  Future<void> exit() async {
    _tdJsonClient.exit();
    await _tdStreamController.close();
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

  Future<TgMsgResponseReadChatHistory> readChatsHistory({
    required DateTime datetimeFrom,
    required List<String> chatsNames,
  }) async {
    _logger.info('reading chats history...');

    for (var chatName in chatsNames) {
      _logger.info('[$chatName] reading chat history...');

      await _readChatHistory(
        datetimeFrom: datetimeFrom,
        chatName: chatName,
      );

      _logger.info('[$chatName] reading chat history... done.');
    }

    return TgMsgResponseReadChatHistory();
  }

  Future<void> _readChatHistory({
    required DateTime datetimeFrom,
    required String chatName,
  }) async {
    var chat = await _searchPublicChat(chatName: chatName);

    if (chat == null) {
      return;
    }

    if (chat.id == null) {
      _logger.warning('[$chatName] chat id is null.');
      return;
    }
    _logger.info('[$chatName] chat id is ${chat.id}.');

    var chatId = WrapId.unwrapChatId(chat.id);
    if (chatId == null) {
      _logger.warning('[$chatName] could not unwrap ${chat.id}.');
      return;
    }
    _logger.info('[$chatName] unwrapped chat id is $chatId.');

    await _saveChat(
      chatName: chatName,
      chat: chat,
    );

    var messsageIdLast = await _searchMessageIdLast(
      datetimeFrom: datetimeFrom,
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

  Future<Chat?> _searchPublicChat({
    required String chatName,
  }) async {
    _logger.info('[$chatName] searching public chat...');

    var extra = Uuid().v1();
    _tdSend(SearchPublicChat(
      username: chatName,
      extra: extra,
    ));

    var response = await _tdStreamController.stream
        .where((event) => event.extra == extra)
        .first;

    var chat;

    if (response is Error) {
      _logger.warning('[$chatName] searching public chat failed with error.');
      _logger.warning('[$chatName] $response.');
    } else if (response is Chat) {
      chat = response;
    }

    _logger.info('[$chatName] searching public chat... done.');

    return chat;
  }

  Future<int?> _searchMessageIdLast({
    required DateTime datetimeFrom,
    required String chatName,
    required int chatId,
  }) async {
    _logger.info('[$chatName] searching last message by date...');

    var messageIdLast;

    messageIdLast = await _searchMessageIdLastLocally(
      datetimeFrom: datetimeFrom,
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

  Future<void> _saveChat({
    required String chatName,
    required Chat chat,
  }) async {
    _logger.info('[$chatName] saving chat...');
    // TODO: save chat in Db
    dbIsolateSendPort.send([SaveChat(), chatName, chat]);
    _logger.info('[$chatName] saving chat... done.');
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
      if (message.chat_id == null ||
          message.id == null ||
          message.date == null) {
        continue;
      }

      var userId = null;
      if (message.sender_id != null &&
          message.sender_id.runtimeType == MessageSenderUser) {
        userId = (message.sender_id as MessageSenderUser).user_id;
      }

      var text = null;
      if (message.content != null &&
          message.content.runtimeType == MessageText) {
        var formattedText = (message.content as MessageText).text;
        if (formattedText != null) {
          text = formattedText.text;
        }
      }

      var messageId = WrapId.unwrapMessageId(message.id);
      // TODO: save message here
      dbIsolateSendPort.send([SaveMessages(), chatId, messageId, message.date, userId, text]);

      messageCount += 1;

      if (messageId != null) {
        if (messageIdLast == null) {
          messageIdLast = messageId;
        } else if (messageId > messageIdLast) {
          messageIdLast = messageId;
        }
      }
    }

    _logger.info('[$chatName] saved ${messageCount} messages.');

    return messageIdLast;
  }

  Future<int?> _searchMessageIdLastLocally({
    required DateTime datetimeFrom,
    required String chatName,
    required int chatId,
  }) async {
    _logger.info('[$chatName] searching last message id locally...');

    // TODO: search last message id in DB
    dbIsolateSendPort.send([SearchMessageIdLastLocally(), datetimeFrom, chatName, chatId]);
    var messageIdLast = await _tdStreamController.stream
        .where((event) => event is IsolateMaxMessageId)
        .first;

    _logger.info('[$chatName] searching last message id locally... done.');
    return messageIdLast;
  }
}

abstract class TgMsg {}

abstract class TgMsgRequest extends TgMsg {}

abstract class TgMsgResponse extends TgMsg {}

class TgMsgRequestExit extends TgMsgRequest {}

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

class TgMsgRequestReadChatsHistory extends TgMsgRequest {
  final DateTime datetimeFrom;
  final List<string> chatsNames;

  TgMsgRequestReadChatsHistory({
    required this.datetimeFrom,
    required this.chatsNames,
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
  }) {}
}

class TgMsgResponseReadChatHistory extends TgMsgResponse {}

class SaveChat extends DbOperation {}

class SaveMessages extends DbOperation {}

class SearchMessageIdLastLocally extends DbOperation {}

