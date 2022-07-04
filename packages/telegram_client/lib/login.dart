import 'dart:async';

import 'package:td_json_client/td_json_client.dart';

import 'isolated.dart';

class Login extends IsolatedSubscriber {
  final SetTdlibParameters setTdlibParameters;
  final CheckDatabaseEncryptionKey checkDatabaseEncryptionKey;
  final SetAuthenticationPhoneNumber setAuthenticationPhoneNumber;
  final CheckAuthenticationCodeWithCallback checkAuthenticationCodeWithCallback;
  final AuthorizationStateWaitOtherDeviceConfirmationWithCallback
      authorizationStateWaitOtherDeviceConfirmationWithCallback;
  final RegisterUserWithCallback registerUserWithCallback;
  final CheckAuthenticationPasswordWithCallback
      checkAuthenticationPasswordWithCallback;

  static Future<Login> create({
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
  }) async {
    final Login login = Login._create(
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
    await login.spawn();
    return login;
  }

  Login._create({
    required this.setTdlibParameters,
    required this.checkDatabaseEncryptionKey,
    required this.setAuthenticationPhoneNumber,
    required this.checkAuthenticationCodeWithCallback,
    required this.authorizationStateWaitOtherDeviceConfirmationWithCallback,
    required this.registerUserWithCallback,
    required this.checkAuthenticationPasswordWithCallback,
  });

  @override
  void onSubscribedMessage(SubscribedMessage isolateMessage) {
    publisherReceivePortBroadcast
        ?.where((message) =>
            message is TdObjectMessage &&
            message.td is UpdateAuthorizationState)
        .listen((event) {
      onUpdateAuthorizationState(event.td);
    });

    publisherReceivePortBroadcast
        ?.where((message) => message is TdObjectMessage && message.td is Error)
        .listen((event) {
      onError(event.td);
    });

    publisherSendPort.send(TdFunctionMessage(
      td: GetAuthorizationState(),
    ));
  }

  void onUpdateAuthorizationState(
      UpdateAuthorizationState updateAuthorizationState) {
    switch (updateAuthorizationState.authorization_state.runtimeType) {
      case AuthorizationStateWaitTdlibParameters:
        publisherSendPort.send(TdFunctionMessage(td: setTdlibParameters));
        break;

      case AuthorizationStateWaitEncryptionKey:
        publisherSendPort
            .send(TdFunctionMessage(td: checkDatabaseEncryptionKey));
        break;

      case AuthorizationStateWaitPhoneNumber:
        publisherSendPort
            .send(TdFunctionMessage(td: setAuthenticationPhoneNumber));
        break;

      case AuthorizationStateWaitCode:
        publisherSendPort.send(TdFunctionMessage(
            td: CheckAuthenticationCode(
                code: checkAuthenticationCodeWithCallback.readTelegramCode())));
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
        publisherSendPort.send(TdFunctionMessage(
            td: RegisterUser(
                first_name: registerUserWithCallback.readUserFirstName(),
                last_name: registerUserWithCallback.readUserLastName())));
        break;

      case AuthorizationStateWaitPassword:
        publisherSendPort.send(TdFunctionMessage(
            td: CheckAuthenticationPassword(
                password: checkAuthenticationPasswordWithCallback
                    .readUserPassword())));
        break;

      case AuthorizationStateReady:
        break;
      case AuthorizationStateLoggingOut:
        break;
      case AuthorizationStateClosing:
        break;
      case AuthorizationStateClosed:
        break;
    }
  }

  void onError(Error error) {
    print(error);
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
