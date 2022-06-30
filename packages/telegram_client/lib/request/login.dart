import 'package:td_json_client/td_json_client.dart';
import 'package:telegram_client/request/request.dart';

import '../exception.dart';

class LoginRequest extends Request {
  final SetTdlibParameters setTdlibParameters;
  final CheckDatabaseEncryptionKey checkDatabaseEncryptionKey;
  final SetAuthenticationPhoneNumber setAuthenticationPhoneNumber;
  final CheckAuthenticationCodeWithCallback checkAuthenticationCodeWithCallback;
  final AuthorizationStateWaitOtherDeviceConfirmationWithCallback
      authorizationStateWaitOtherDeviceConfirmationWithCallback;
  final RegisterUserWithCallback registerUserWithCallback;
  final CheckAuthenticationPasswordWithCallback
      checkAuthenticationPasswordWithCallback;

  bool _isAuthorized = false;
  bool get isAuthorized => _isAuthorized;
  bool _isClosed = false;
  bool get isClosed => _isClosed;

  LoginRequest({
    required this.setTdlibParameters,
    required this.checkDatabaseEncryptionKey,
    required this.setAuthenticationPhoneNumber,
    required this.checkAuthenticationCodeWithCallback,
    required this.authorizationStateWaitOtherDeviceConfirmationWithCallback,
    required this.registerUserWithCallback,
    required this.checkAuthenticationPasswordWithCallback,
  });

  @override
  Future<dynamic> execute(
    TdJsonClient tdJsonClient,
    int clientId, {
    double waitTimeout = 10.0,
  }) async {
    await tdJsonClient.send(clientId, GetAuthorizationState());

    await for (var response in tdJsonClient
        .receive(waitTimeout: waitTimeout)
        .where(
            (event) => event is UpdateAuthorizationState || event is Error)) {
      if (response is Error) {
        loggy.error(response);
        var error = response as Error;
        throw LoginMessageException(
          code: error.code,
          message: error.message,
        );
      }

      var updateAuthorizationState = response as UpdateAuthorizationState;
      switch (updateAuthorizationState.authorization_state.runtimeType) {
        case AuthorizationStateWaitTdlibParameters:
          tdJsonClient.send(
            clientId,
            setTdlibParameters,
          );
          break;

        case AuthorizationStateWaitEncryptionKey:
          tdJsonClient.send(
            clientId,
            checkDatabaseEncryptionKey,
          );
          break;

        case AuthorizationStateWaitPhoneNumber:
          tdJsonClient.send(
            clientId,
            setAuthenticationPhoneNumber,
          );
          break;

        case AuthorizationStateWaitCode:
          tdJsonClient.send(
            clientId,
            CheckAuthenticationCode(
                code: checkAuthenticationCodeWithCallback.readTelegramCode()),
          );
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
          tdJsonClient.send(
              clientId,
              RegisterUser(
                  first_name: registerUserWithCallback.readUserFirstName(),
                  last_name: registerUserWithCallback.readUserLastName()));
          break;

        case AuthorizationStateWaitPassword:
          tdJsonClient.send(
              clientId,
              CheckAuthenticationPassword(
                  password: checkAuthenticationPasswordWithCallback
                      .readUserPassword()));
          break;

        case AuthorizationStateReady:
          _isAuthorized = true;
          loggy.info('Logged in successfuly.');
          break;
        case AuthorizationStateLoggingOut:
          loggy.info('Logging out.');
          break;
        case AuthorizationStateClosing:
          loggy.info('Tdlib is closing.');
          break;
        case AuthorizationStateClosed:
          _isClosed = true;
          loggy.info('Tdlib is closed.');
          break;
      }

      if (_isClosed || _isAuthorized) {
        break;
      }
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

class LoginMessageException extends MessageException {
  LoginMessageException({super.code, super.message});
}
