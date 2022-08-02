import 'dart:isolate';

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

  Login({
    required this.setTdlibParameters,
    required this.checkDatabaseEncryptionKey,
    required this.setAuthenticationPhoneNumber,
    required this.checkAuthenticationCodeWithCallback,
    required this.authorizationStateWaitOtherDeviceConfirmationWithCallback,
    required this.registerUserWithCallback,
    required this.checkAuthenticationPasswordWithCallback,
    super.telegramSender,
  });

  void auth() {
    send(GetAuthorizationState());
  }

  @override
  void onEvent(event) {
    if (event is UpdateAuthorizationState) {
      _onUpdateAuthorizationState(event);
    } else if (event is Error) {
      _onError(event);
    }
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

  static bool isLoginEvent(dynamic event) {
    return event is UpdateAuthorizationState || event is Error;
  }

  Future<void> _onError(
    Error error,
  ) async {
    print('${Isolate.current.debugName} $runtimeType._onError $error');
  }

  static Future<LoginIsolated> isolate({
    required SetTdlibParameters setTdlibParameters,
    required CheckDatabaseEncryptionKey checkDatabaseEncryptionKey,
    required SetAuthenticationPhoneNumber setAuthenticationPhoneNumber,
    required CheckAuthenticationCodeWithCallback
        checkAuthenticationCodeWithCallback,
    required AuthorizationStateWaitOtherDeviceConfirmationWithCallback
        authorizationStateWaitOtherDeviceConfirmationWithCallback,
    required RegisterUserWithCallback registerUserWithCallback,
    required CheckAuthenticationPasswordWithCallback
        checkAuthenticationPasswordWithCallback,
    TelegramSender? telegramSender,
  }) async {
    LoginIsolated instance = LoginIsolated(
      setTdlibParameters: setTdlibParameters,
      checkDatabaseEncryptionKey: checkDatabaseEncryptionKey,
      setAuthenticationPhoneNumber: setAuthenticationPhoneNumber,
      checkAuthenticationCodeWithCallback: checkAuthenticationCodeWithCallback,
      authorizationStateWaitOtherDeviceConfirmationWithCallback:
          authorizationStateWaitOtherDeviceConfirmationWithCallback,
      registerUserWithCallback: registerUserWithCallback,
      checkAuthenticationPasswordWithCallback:
          checkAuthenticationPasswordWithCallback,
      telegramSender: telegramSender,
    );
    await instance.spawn();
    return instance;
  }
}

class LoginIsolated extends Login with Isolated {
  LoginIsolated({
    required super.setTdlibParameters,
    required super.checkDatabaseEncryptionKey,
    required super.setAuthenticationPhoneNumber,
    required super.checkAuthenticationCodeWithCallback,
    required super.authorizationStateWaitOtherDeviceConfirmationWithCallback,
    required super.registerUserWithCallback,
    required super.checkAuthenticationPasswordWithCallback,
    super.telegramSender,
  }) {
    init(
      instance: Login(
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
      messageHandler: LoginIsolated.handleMessage,
    );
  }

  @override
  void auth() {
    isolateSendPort?.send(Auth());
  }

  static void handleMessage(dynamic message, TelegramEventListener instance) {
    if (message is Auth) {
      (instance as Login).auth();
    } else {
      Isolated.handleMessage(message, instance);
    }
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
