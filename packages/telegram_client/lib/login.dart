import 'dart:isolate';

import 'package:uuid/uuid.dart';
import 'package:td_json_client/td_json_client.dart';

import 'base.dart';

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
    uniqueKey = Uuid().v1();
  }

  @override
  void update(event) {
    _isolateSendPort?.send(UpdateEvent(event));
  }

  @override
  void auth() {
    _isolateSendPort?.send(Auth());
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
      } else if (message is UpdateEvent) {
        login.update(message.event);
      }
    });
  }

  @override
  void exit() {
    _isolateReceivePort.close();
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

class Auth {}
