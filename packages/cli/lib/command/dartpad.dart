import 'dart:async';
import 'dart:isolate';

import 'package:uuid/uuid.dart';
import 'package:td_json_client/td_json_client.dart';

import 'base.dart';
import '../callback/cli.dart';

class TelegramCommandDartpad extends TelegramCommand {
  final name = 'dartpad';
  final description = 'Login a Telegram account.';

  void run() async {
    // var telegramClient = TelegramClient(
    //   libtdjsonPath: globalResults!['libtdjson-path'],
    // );
    var telegramClient = await TelegramClient.isolate(
      libtdjsonPath: globalResults!['libtdjson-path'],
    );
    var login = await Login.isolate(
      setTdlibParameters: SetTdlibParameters(
        parameters: TdlibParameters(
          api_id: int.parse(globalResults!['api-id']),
          api_hash: globalResults!['api-hash'],
          database_directory: globalResults!['database-path'],
          use_message_database: false,
          device_model: 'Desktop',
          application_version: '1.0',
          system_language_code: 'en',
        ),
      ),
      checkDatabaseEncryptionKey: CheckDatabaseEncryptionKey(
        encryption_key: '',
      ),
      setAuthenticationPhoneNumber: SetAuthenticationPhoneNumber(
        phone_number: globalResults!['phone-number'],
      ),
      checkAuthenticationCodeWithCallback: CheckAuthenticationCodeWithCallback(
        readTelegramCode: readTelegramCode,
      ),
      authorizationStateWaitOtherDeviceConfirmationWithCallback:
          AuthorizationStateWaitOtherDeviceConfirmationWithCallback(
        writeQrCodeLink: writeQrCodeLink,
      ),
      registerUserWithCallback: RegisterUserWithCallback(
        readUserFirstName: readUserFirstName,
        readUserLastName: readUserLastName,
      ),
      checkAuthenticationPasswordWithCallback:
          CheckAuthenticationPasswordWithCallback(
              readUserPassword: readUserPassword),
    );

    telegramClient.addeventListener(login);

    login.setTelegramClient(telegramClient);
    login.auth();

    await Future.delayed(const Duration(seconds: 5));
    telegramClient.removeEventListener(login);

    await Future.delayed(const Duration(seconds: 5));
    login.exit();
    telegramClient.exit();
  }
}

abstract class TelegramEventGenerator {
  void addeventListener(TelegramEventListener telegramEventListener);
  void removeEventListener(TelegramEventListener telegramEventListener);

  void exit() {}
}

abstract class TelegramEventListener {
  late final String uniqueKey;
  void update(event);

  void exit() {}
}

abstract class TelegramSend {
  void send(TdFunction tdFunction);
}

class TelegramClient extends TelegramEventGenerator implements TelegramSend {
  final String libtdjsonPath;

  late final StreamController _tdStreamController;
  Stream<dynamic> get telegramEvents => _tdStreamController.stream;

  TelegramClient({
    required this.libtdjsonPath,
  }) {
    _tdStreamController = StreamController.broadcast(
      onListen: _tdStart,
      onCancel: _tdStop,
    );
  }

  bool _isInitialized = false;
  late final TdJsonClient _tdJsonClient;
  late final int _tdJsonClientId;
  void init() {
    if (!_isInitialized) {
      _tdJsonClient = TdJsonClient(libtdjsonPath: libtdjsonPath);
      _tdJsonClientId = _tdJsonClient.create_client_id();
      _isInitialized = true;
    }
  }

  Duration readEventsFrequency = Duration(milliseconds: 10);
  Timer? timer;
  void _tdStart() {
    init();

    print('${Isolate.current.debugName} $runtimeType._tdStart');
    timer = Timer.periodic(readEventsFrequency, _tdReceive);
  }

  void _tdStop() {
    init();

    print('${Isolate.current.debugName} $runtimeType._tdStop');
    timer?.cancel();
    timer = null;
  }

  double waitTimeout = 0.005;
  bool _isTdReceiving = false;
  void _tdReceive(Timer timer) {
    init();

    if (!_isTdReceiving) {
      _isTdReceiving = true;

      var event = _tdJsonClient.receive(waitTimeout: waitTimeout);
      if (event != null) {
        // print('${Isolate.current.debugName} $runtimeType._tdReceive $event');
        _tdStreamController.add(event);
      }

      _isTdReceiving = false;
    }
  }

  @override
  void send(
    TdFunction tdFunction,
  ) {
    init();

    _tdJsonClient.send(_tdJsonClientId, tdFunction);
    print('${Isolate.current.debugName} $runtimeType.send $tdFunction');
  }

  Map<String, StreamSubscription> _eventListeners = {};

  @override
  void addeventListener(TelegramEventListener telegramEventListener) {
    _eventListeners[telegramEventListener.uniqueKey] =
        telegramEvents.listen((event) {
      telegramEventListener.update(event);
    });
  }

  @override
  void removeEventListener(TelegramEventListener telegramEventListener) {
    var listener = _eventListeners.remove(telegramEventListener.uniqueKey);
    listener?.cancel();
  }

  static Future<TelegramClientIsolated> isolate({
    required libtdjsonPath,
  }) async {
    TelegramClientIsolated telegramClientIsolated =
        TelegramClientIsolated(libtdjsonPath: libtdjsonPath);
    await telegramClientIsolated.spawn();
    return telegramClientIsolated;
  }
}

class TelegramClientIsolated extends TelegramClient {
  late final ReceivePort _isolateReceivePort;
  late final Stream<dynamic> _isolateReceivePortBroadcast;
  SendPort? _isolateSendPort;

  TelegramClientIsolated({
    required super.libtdjsonPath,
  }) {
    _isolateReceivePort = ReceivePort();
    _isolateReceivePortBroadcast = _isolateReceivePort.asBroadcastStream();
  }

  @override
  void send(
    TdFunction tdFunction,
  ) {
    _isolateSendPort?.send(tdFunction);
  }

  @override
  void addeventListener(TelegramEventListener telegramEventListener) {
    _eventListeners[telegramEventListener.uniqueKey] =
        _isolateReceivePortBroadcast.listen((event) {
      telegramEventListener.update(event);
    });

    _isolateSendPort?.send(AddEventListener(SendPortEventListener(
      telegramEventListener.uniqueKey,
      _isolateReceivePort.sendPort,
    )));
  }

  @override
  void removeEventListener(TelegramEventListener telegramEventListener) {
    super.removeEventListener(telegramEventListener);

    _isolateSendPort?.send(RemoveEventListener(SendPortEventListener(
      telegramEventListener.uniqueKey,
      _isolateReceivePort.sendPort,
    )));
  }

  Future<void> spawn() async {
    await Isolate.spawn(
      TelegramClientIsolated._entryPoint,
      [
        TelegramClient(libtdjsonPath: libtdjsonPath),
        _isolateReceivePort.sendPort
      ],
      debugName: runtimeType.toString(),
    );
    _isolateSendPort = await _isolateReceivePortBroadcast.first;
  }

  static void _entryPoint(List<dynamic> initialSpawnMessage) {
    TelegramClient telegramClient = initialSpawnMessage[0];
    SendPort parentSendPort = initialSpawnMessage[1];

    var receivePort = ReceivePort();
    parentSendPort.send(receivePort.sendPort);

    receivePort.listen((message) {
      if (message is TdFunction) {
        telegramClient.send(message);
      } else if (message is AddEventListener) {
        telegramClient.addeventListener(message.eventListener);
      } else if (message is RemoveEventListener) {
        telegramClient.removeEventListener(message.eventListener);
      }
    });
  }

  void exit() {
    _isolateReceivePort.close();
  }
}

class AddEventListener {
  TelegramEventListener eventListener;
  AddEventListener(
    this.eventListener,
  );
}

class RemoveEventListener {
  TelegramEventListener eventListener;
  RemoveEventListener(
    this.eventListener,
  );
}

class SendPortEventListener extends TelegramEventListener {
  SendPort sendPort;
  SendPortEventListener(
    String uniqueKey,
    this.sendPort,
  ) {
    this.uniqueKey = uniqueKey;
  }

  @override
  void update(event) {
    sendPort.send(event);
  }
}

class Login extends TelegramEventListener {
  final SetTdlibParameters setTdlibParameters;
  final CheckDatabaseEncryptionKey checkDatabaseEncryptionKey;
  final SetAuthenticationPhoneNumber setAuthenticationPhoneNumber;
  final CheckAuthenticationCodeWithCallback checkAuthenticationCodeWithCallback;
  final AuthorizationStateWaitOtherDeviceConfirmationWithCallback
      authorizationStateWaitOtherDeviceConfirmationWithCallback;
  final RegisterUserWithCallback registerUserWithCallback;
  final CheckAuthenticationPasswordWithCallback
      checkAuthenticationPasswordWithCallback;

  Login(
      {required this.setTdlibParameters,
      required this.checkDatabaseEncryptionKey,
      required this.setAuthenticationPhoneNumber,
      required this.checkAuthenticationCodeWithCallback,
      required this.authorizationStateWaitOtherDeviceConfirmationWithCallback,
      required this.registerUserWithCallback,
      required this.checkAuthenticationPasswordWithCallback}) {
    uniqueKey = Uuid().v1();
  }

  void auth() {
    send(GetAuthorizationState());
  }

  void send(TdFunction tdFunction) {
    _telegramClient?.send(tdFunction);
  }

  @override
  void update(event) {
    if (event is UpdateAuthorizationState) {
      _onUpdateAuthorizationState(event);
    } else if (event is Error) {
      _onError(event);
    }
  }

  TelegramSend? _telegramClient;

  void setTelegramClient(TelegramSend telegramClient) {
    _telegramClient = telegramClient;
  }

  bool _isAuthorized = false;
  bool get isAuthorized => _isAuthorized;

  bool _isClosed = false;
  bool get isclosed => _isClosed;

  Future<void> _onUpdateAuthorizationState(
    UpdateAuthorizationState updateAuthorizationState,
  ) async {
    print(
        '${Isolate.current.debugName} $runtimeType._onUpdateAuthorizationState $updateAuthorizationState');
    switch (updateAuthorizationState.authorization_state.runtimeType) {
      case AuthorizationStateWaitTdlibParameters:
        send(setTdlibParameters);
        break;

      case AuthorizationStateWaitEncryptionKey:
        send(checkDatabaseEncryptionKey);
        break;

      case AuthorizationStateWaitPhoneNumber:
        send(setAuthenticationPhoneNumber);
        break;

      case AuthorizationStateWaitCode:
        send(CheckAuthenticationCode(
            code: checkAuthenticationCodeWithCallback.readTelegramCode()));
        break;

      case AuthorizationStateWaitOtherDeviceConfirmation:
        var authorizationStateWaitOtherDeviceConfirmation =
            updateAuthorizationState
                as AuthorizationStateWaitOtherDeviceConfirmation;
        authorizationStateWaitOtherDeviceConfirmationWithCallback
            .writeQrCodeLink(
                authorizationStateWaitOtherDeviceConfirmation.link);
        break;

      case AuthorizationStateWaitRegistration:
        send(RegisterUser(
            first_name: registerUserWithCallback.readUserFirstName(),
            last_name: registerUserWithCallback.readUserLastName()));
        break;

      case AuthorizationStateWaitPassword:
        send(CheckAuthenticationPassword(
            password:
                checkAuthenticationPasswordWithCallback.readUserPassword()));
        break;

      case AuthorizationStateReady:
        _isAuthorized = true;
        break;
      case AuthorizationStateLoggingOut:
        _isClosed = true;
        break;
      case AuthorizationStateClosing:
        _isClosed = true;
        break;
      case AuthorizationStateClosed:
        _isClosed = true;
        break;
    }
  }

  Future<void> _onError(
    Error error,
  ) async {
    print('${Isolate.current.debugName} $runtimeType._onError $error');
  }

  void exit() {}

  static Future<LoginIsolated> isolate(
      {required setTdlibParameters,
      required checkDatabaseEncryptionKey,
      required setAuthenticationPhoneNumber,
      required checkAuthenticationCodeWithCallback,
      required authorizationStateWaitOtherDeviceConfirmationWithCallback,
      required registerUserWithCallback,
      required checkAuthenticationPasswordWithCallback}) async {
    LoginIsolated loginIsolated = LoginIsolated(
      setTdlibParameters: setTdlibParameters,
      checkDatabaseEncryptionKey: checkDatabaseEncryptionKey,
      setAuthenticationPhoneNumber: setAuthenticationPhoneNumber,
      checkAuthenticationCodeWithCallback: checkAuthenticationCodeWithCallback,
      authorizationStateWaitOtherDeviceConfirmationWithCallback:
          authorizationStateWaitOtherDeviceConfirmationWithCallback,
      registerUserWithCallback: registerUserWithCallback,
      checkAuthenticationPasswordWithCallback:
          checkAuthenticationPasswordWithCallback,
    );
    await loginIsolated.spawn();
    return loginIsolated;
  }
}

class LoginIsolated extends Login {
  late final ReceivePort _isolateReceivePort;
  late final Stream<dynamic> _isolateReceivePortBroadcast;
  SendPort? _isolateSendPort;

  LoginIsolated(
      {required super.setTdlibParameters,
      required super.checkDatabaseEncryptionKey,
      required super.setAuthenticationPhoneNumber,
      required super.checkAuthenticationCodeWithCallback,
      required super.authorizationStateWaitOtherDeviceConfirmationWithCallback,
      required super.registerUserWithCallback,
      required super.checkAuthenticationPasswordWithCallback}) {
    _isolateReceivePort = ReceivePort();
    _isolateReceivePortBroadcast = _isolateReceivePort.asBroadcastStream();
  }

  @override
  void update(event) {
    _isolateSendPort?.send(Update(event));
  }

  @override
  void auth() {
    _isolateSendPort?.send(Auth());
  }

  void setTelegramClient(TelegramSend telegramClient) {
    _telegramClient = telegramClient;
  }

  Future<void> spawn() async {
    await Isolate.spawn(
      LoginIsolated._entryPoint,
      [
        Login(
          setTdlibParameters: setTdlibParameters,
          checkDatabaseEncryptionKey: checkDatabaseEncryptionKey,
          setAuthenticationPhoneNumber: setAuthenticationPhoneNumber,
          checkAuthenticationCodeWithCallback:
              checkAuthenticationCodeWithCallback,
          authorizationStateWaitOtherDeviceConfirmationWithCallback:
              authorizationStateWaitOtherDeviceConfirmationWithCallback,
          registerUserWithCallback: registerUserWithCallback,
          checkAuthenticationPasswordWithCallback:
              checkAuthenticationPasswordWithCallback,
        ),
        _isolateReceivePort.sendPort
      ],
      debugName: runtimeType.toString(),
    );
    _isolateSendPort = await _isolateReceivePortBroadcast.first;
    _isolateReceivePortBroadcast.listen((event) {
      if (event is TdFunction) {
        _telegramClient?.send(event);
      }
    });
  }

  static void _entryPoint(List<dynamic> initialSpawnMessage) {
    Login login = initialSpawnMessage[0];
    SendPort parentSendPort = initialSpawnMessage[1];

    var receivePort = ReceivePort();
    parentSendPort.send(receivePort.sendPort);

    login.setTelegramClient(SetTelegramSend(parentSendPort));

    receivePort.listen((message) {
      if (message is Auth) {
        login.auth();
      } else if (message is Update) {
        login.update(message.event);
      }
    });
  }

  @override
  void exit() {
    _isolateReceivePort.close();
  }
}

class Auth {}

class Update {
  dynamic event;
  Update(
    this.event,
  );
}

class SetTelegramSend extends TelegramSend {
  SendPort sendPort;
  SetTelegramSend(this.sendPort);
  @override
  void send(TdFunction tdFunction) {
    sendPort.send(tdFunction);
  }
}

class CheckAuthenticationCodeWithCallback extends CheckAuthenticationCode {
  final String Function() readTelegramCode;
  CheckAuthenticationCodeWithCallback({
    required this.readTelegramCode,
  });
}

class AuthorizationStateWaitOtherDeviceConfirmationWithCallback
    extends AuthorizationStateWaitOtherDeviceConfirmation {
  final void Function(String? link) writeQrCodeLink;
  AuthorizationStateWaitOtherDeviceConfirmationWithCallback({
    required this.writeQrCodeLink,
  });
}

class RegisterUserWithCallback extends RegisterUser {
  final String Function() readUserFirstName;
  final String Function() readUserLastName;
  RegisterUserWithCallback({
    required this.readUserFirstName,
    required this.readUserLastName,
  });
}

class CheckAuthenticationPasswordWithCallback
    extends CheckAuthenticationPassword {
  final String Function() readUserPassword;
  CheckAuthenticationPasswordWithCallback({
    required this.readUserPassword,
  });
}
