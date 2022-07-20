import 'dart:async';
import 'dart:isolate';

import 'package:td_json_client/td_json_client.dart';
import 'package:telegram_client/client.dart';
import 'package:telegram_client/port.dart';

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

  void _onUpdateAuthorizationState({
    required SendPort? telegramClientSendPort,
    required UpdateAuthorizationState updateAuthorizationState,
  }) {
    switch (updateAuthorizationState.authorization_state.runtimeType) {
      case AuthorizationStateWaitTdlibParameters:
        telegramClientSendPort?.send(setTdlibParameters);
        break;

      case AuthorizationStateWaitEncryptionKey:
        telegramClientSendPort?.send(checkDatabaseEncryptionKey);
        break;

      case AuthorizationStateWaitPhoneNumber:
        telegramClientSendPort?.send(setAuthenticationPhoneNumber);
        break;

      case AuthorizationStateWaitCode:
        telegramClientSendPort?.send(CheckAuthenticationCode(
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
        telegramClientSendPort?.send(RegisterUser(
            first_name: registerUserWithCallback.readUserFirstName(),
            last_name: registerUserWithCallback.readUserLastName()));
        break;

      case AuthorizationStateWaitPassword:
        telegramClientSendPort?.send(CheckAuthenticationPassword(
            password:
                checkAuthenticationPasswordWithCallback.readUserPassword()));
        break;

      case AuthorizationStateReady:
        _isAuthorized = true;
        _unsubscribe(telegramClientSendPort);
        break;
      case AuthorizationStateLoggingOut:
        _isClosed = true;
        _unsubscribe(telegramClientSendPort);
        break;
      case AuthorizationStateClosing:
        _isClosed = true;
        _unsubscribe(telegramClientSendPort);
        break;
      case AuthorizationStateClosed:
        _isClosed = true;
        _unsubscribe(telegramClientSendPort);
        break;
    }
  }

  void _onError({
    required SendPort? telegramClientSendPort,
    required Error error,
  }) {}

  ReceivePort? _telegramClientReceivePort;

  StreamSubscription? _authSubscription;
  StreamSubscription? _errorSuscription;

  void auth({
    required SendPort? telegramClientSendPort,
  }) {
    _telegramClientReceivePort = ReceivePort();

    telegramClientSendPort?.send(SubscribeTelegramEvents(
      sendPort: _telegramClientReceivePort!.sendPort,
    ));

    var telegramClientEvents = _telegramClientReceivePort!.asBroadcastStream();
    _authSubscription = telegramClientEvents
        .where((event) => event is UpdateAuthorizationState)
        .listen((message) {
      print('${Isolate.current.debugName} received $runtimeType $message');

      _onUpdateAuthorizationState(
        telegramClientSendPort: telegramClientSendPort,
        updateAuthorizationState: message,
      );
    });

    _errorSuscription =
        telegramClientEvents.where((event) => event is Error).listen((message) {
      print('${Isolate.current.debugName} received $runtimeType $message');
      _onError(
        telegramClientSendPort: telegramClientSendPort,
        error: message,
      );
    });

    telegramClientSendPort?.send(GetAuthorizationState());
  }

  void _unsubscribe(
    SendPort? telegramClientSendPort,
  ) {
    telegramClientSendPort?.send(UnsubscribeTelegramEvents(
      sendPort: _telegramClientReceivePort!.sendPort,
    ));
    _cancelStreamSubscriptions();
  }

  void _cancelStreamSubscriptions() {
    _authSubscription?.cancel();
    _errorSuscription?.cancel();
  }

  @override
  void handlePortMessage(dynamic portMessage) {
    if (portMessage is AuthenticateAccount) {
      auth(
        telegramClientSendPort: portMessage.telegramClientSendPort,
      );
    }
  }

  // void exit() {
  //   _cancelStreamSubscriptions();
  // }
}

class AuthenticateAccount {
  final SendPort? telegramClientSendPort;
  AuthenticateAccount({
    this.telegramClientSendPort,
  });
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
