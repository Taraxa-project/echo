import 'package:td_json_client/td_json_client.dart';
import 'package:telegram_client/request/request.dart';

class LoginRequest extends Request {
  final SetTdlibParameters setTdlibParameters;
  final CheckDatabaseEncryptionKey checkDatabaseEncryptionKey;
  final SetAuthenticationPhoneNumber setAuthenticationPhoneNumber;
  final CheckAuthenticationCodeCallback checkAuthenticationCode;

  bool _isAuthorized = false;
  bool get isAuthorized => _isAuthorized;
  bool _isClosed = false;
  bool get isClosed => _isClosed;

  LoginRequest({
    required this.setTdlibParameters,
    required this.checkDatabaseEncryptionKey,
    required this.setAuthenticationPhoneNumber,
    required this.checkAuthenticationCode,
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
        .where((event) => event is UpdateAuthorizationState)) {
      var updateAuthorizationState = response as UpdateAuthorizationState;
      switch (updateAuthorizationState.authorization_state.runtimeType) {
        case AuthorizationStateClosed:
          loggy.warning('Authorization state closed.');
          _isClosed = true;
          break;

        case AuthorizationStateReady:
          _isAuthorized = true;
          loggy.info('Logged in successfuly.');
          break;

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
                code: checkAuthenticationCode.readTelegramCode()),
          );
          break;
      }

      if (_isClosed || _isAuthorized) {
        break;
      }
    }
  }
}

class CheckAuthenticationCodeCallback extends CheckAuthenticationCode {
  final String Function() readTelegramCode;
  CheckAuthenticationCodeCallback({
    required this.readTelegramCode,
  });
}
