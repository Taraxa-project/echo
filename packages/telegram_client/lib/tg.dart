import 'dart:async';
import 'dart:isolate';

import 'package:logging/logging.dart';
import 'package:td_json_client/td_json_client.dart';
import 'package:uuid/uuid.dart';

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
    required libtdjsonlcPath,
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

    _logger.info('spawning TgIsolated...');
    await Isolate.spawn(
      Tg._entryPoint,
      [
        _isolateReceivePort.sendPort,
        libtdjsonlcPath,
      ],
      debugName: runtimeType.toString(),
    );

    _isolateSendPort = await _isolateReceivePortBroadcast.first;
  }

  static void _entryPoint(dynamic initialSpawnMessage) {
    final SendPort parentSendPort = initialSpawnMessage[0];
    final String libtdjsonlcPath = initialSpawnMessage[1];

    var receivePort = ReceivePort();
    parentSendPort.send(receivePort.sendPort);

    final tgIsolated = TgIsolated(
      parentSendPort: parentSendPort,
      libtdjsonlcPath: libtdjsonlcPath,
    );

    receivePort.listen((message) {
      if (message is TgMsgDoExit) {
        tgIsolated._logger.info('exiting...');
        tgIsolated.exit();
        receivePort.close();
        Isolate.exit();
      } else if (message is TgMsgDoLogin) {
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
      } else if (message is TgMsgDoReadChatsHistory) {
        tgIsolated.readChatsHistory();
      }
    });

    tgIsolated._logger.info('spawned.');
  }

  Future<void> exit() async {
    _isolateSendPort.send(TgMsgDoExit());
    await Future.delayed(const Duration(milliseconds: 1000));
    _isolateReceivePort.close();
  }

  Future<dynamic> login({
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
    _isolateSendPort.send(TgMsgDoLogin(
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
        .where((event) => event is TgMsgLogin)
        .first;
  }

  Future<void> readChatsHistory() async {
    _isolateSendPort.send(TgMsgDoReadChatsHistory());
  }
}

abstract class TgMsg {}

class TgMsgDoLogin extends TgMsg {
  final int apiId;
  final String apiHash;
  final String phoneNumber;
  final String databasePath;
  final String Function() readTelegramCode;
  final void Function(String) writeQrCodeLink;
  final String Function() readUserFirstName;
  final String Function() readUserLastName;
  final String Function() readUserPassword;

  TgMsgDoLogin({
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

class TgMsgDoReadChatsHistory extends TgMsg {}

class TgMsgDoExit extends TgMsg {}

class TgIsolated {
  final _logger = Logger('TgIsolated');

  final SendPort parentSendPort;

  final String libtdjsonlcPath;
  late final TdJsonClient _tdJsonClient;
  late final int _tdJsonClientId;

  late final StreamController _tdStreamController;

  double waitTimeout = 0.005;
  bool _isTdReceiving = false;
  Duration readEventsFrequency = Duration(milliseconds: 10);
  Timer? receiveTimer;

  TgIsolated({
    required this.parentSendPort,
    required this.libtdjsonlcPath,
  }) {
    _logger.onRecord.listen((logRecord) {
      parentSendPort.send(logRecord);
    });

    _logger.info('initializing TdJsonClient...');

    _tdJsonClient = TdJsonClient(libtdjsonlcPath: libtdjsonlcPath);
    _tdJsonClientId = _tdJsonClient.create_client_id();

    _logger.info('created client id $_tdJsonClientId.');
    _logger.info('initialization finished.');

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
    _logger.info('starting the receive timer...');
    receiveTimer = Timer.periodic(readEventsFrequency, _tdReceive);
    _logger.info('timer started.');
  }

  void _tdStop() {
    _logger.info('stopping the receive timer...');
    receiveTimer?.cancel();
    receiveTimer = null;
    _logger.info('receive timer stopped.');
  }

  void _tdReceive(Timer timer) {
    if (!_isTdReceiving) {
      _isTdReceiving = true;

      var event = _tdJsonClient.receive(waitTimeout: waitTimeout);
      if (event != null) {
        // _logger.info('received ${event.runtimeType}.');
        _tdStreamController.add(event);
      }

      _isTdReceiving = false;
    }
  }

  void _tdSend(
    TdFunction tdFunction,
  ) {
    _logger.info('sending ${tdFunction.runtimeType}...');
    _tdJsonClient.send(_tdJsonClientId, tdFunction);
    _logger.info('sent ${tdFunction.runtimeType}.');
  }

  Future<TgMsgLogin> login({
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
        _logger.info('login: received ${event.runtimeType}.');
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
      await Future.delayed(const Duration(seconds: 1));
    }

    sub.cancel();

    return TgMsgLogin(
      isAuthorized: isAuthorized,
      isClosed: isClosed,
      isError: isError,
    );
  }

  void readChatsHistory() {
    _logger.info('reading chats history...');
  }
}

class TgMsgLogin {
  bool isAuthorized = false;
  bool isClosed = false;
  bool isError = false;
  TgMsgLogin({
    required this.isAuthorized,
    required this.isClosed,
    required this.isError,
  }) {}
}
