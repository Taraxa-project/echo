import 'dart:async';
import 'dart:isolate';

import 'package:td_json_client/td_json_client.dart';

import 'port.dart';

class Login with WithPorts {
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
  }) {}

  bool _isAuthorized = false;
  bool get isAuthorized => _isAuthorized;

  bool _isClosed = false;
  bool get isclosed => _isClosed;

  Future<void> _onUpdateAuthorizationState({
    required UpdateAuthorizationState updateAuthorizationState,
  }) async {
    switch (updateAuthorizationState.authorization_state.runtimeType) {
      case AuthorizationStateWaitTdlibParameters:
        subscribedSendPort?.send(setTdlibParameters);
        break;

      case AuthorizationStateWaitEncryptionKey:
        subscribedSendPort?.send(checkDatabaseEncryptionKey);
        break;

      case AuthorizationStateWaitPhoneNumber:
        subscribedSendPort?.send(setAuthenticationPhoneNumber);
        break;

      case AuthorizationStateWaitCode:
        subscribedSendPort?.send(CheckAuthenticationCode(
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
        subscribedSendPort?.send(RegisterUser(
            first_name: registerUserWithCallback.readUserFirstName(),
            last_name: registerUserWithCallback.readUserLastName()));
        break;

      case AuthorizationStateWaitPassword:
        subscribedSendPort?.send(CheckAuthenticationPassword(
            password:
                checkAuthenticationPasswordWithCallback.readUserPassword()));
        break;

      case AuthorizationStateReady:
        _isAuthorized = true;
        await _cancelStreamSubscriptions();
        break;
      case AuthorizationStateLoggingOut:
        _isClosed = true;
        await _cancelStreamSubscriptions();
        break;
      case AuthorizationStateClosing:
        _isClosed = true;
        await _cancelStreamSubscriptions();
        break;
      case AuthorizationStateClosed:
        _isClosed = true;
        await _cancelStreamSubscriptions();
        break;
    }
  }

  Future<void> _onError({
    required Error error,
  }) async {}

  StreamSubscription? _authSubscription;
  StreamSubscription? _errorSubscription;

  void auth() {
    _authSubscription = subscribedEvents
        ?.where((event) => event is UpdateAuthorizationState)
        .listen((message) async {
      print('${Isolate.current.debugName} received $runtimeType $message');
      await _onUpdateAuthorizationState(
        updateAuthorizationState: message,
      );
    });

    _errorSubscription = subscribedEvents
        ?.where((event) => event is Error)
        .listen((message) async {
      print('${Isolate.current.debugName} received $runtimeType $message');
      await _onError(
        error: message,
      );
    });

    subscribedSendPort?.send(GetAuthorizationState());
  }

  Future<void> _cancelStreamSubscriptions() async {
    await _authSubscription?.cancel();
    await _errorSubscription?.cancel();
  }

  Future<void> exit() async {
    await _cancelStreamSubscriptions();
    closePorts();
  }

  @override
  void handlePortMessage(dynamic portMessage) {
    if (portMessage is AuthenticateAccount) {
      auth();
    }
  }
}

class AuthenticateAccount {}

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
