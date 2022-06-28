import 'package:loggy/loggy.dart';

import 'package:td_json_client/td_json_client.dart';

mixin TelegramClientLoggy implements LoggyType {
  @override
  Loggy<TelegramClientLoggy> get loggy =>
      Loggy<TelegramClientLoggy>('$runtimeType');

  void setLogLevel(String logLevelName) {
    loggy.level = LogOptions(LogLevel.values.firstWhere(
        (element) => element.name == logLevelName,
        orElse: () => LogLevel.all));
  }
}

class TelegramClient with TelegramClientLoggy {
  final TdJsonClient _tdJsonClient;

  final int apiId;
  final String apiHash;
  final String phoneNumber;
  final String databasePath;

  bool _isAuthorized = false;
  bool get isAuthorized => _isAuthorized;
  bool _isClosed = false;
  bool get isClosed => _isClosed;

  static const double waitTimeout = 10.0;

  TelegramClient(
      {required String libtdjsonPath,
      required int this.apiId,
      required String this.apiHash,
      required String this.phoneNumber,
      required String this.databasePath,
      int libtdjsonLoglevel = 1,
      loglevel = 'Error'})
      : _tdJsonClient = TdJsonClient(
            libtdjsonPath: libtdjsonPath,
            libtdjsonLoglevel: libtdjsonLoglevel,
            loglevel: loglevel) {
    setLogLevel(loglevel);
  }

  int createClientId() {
    return _tdJsonClient.create_client_id();
  }

  Future<void> login(
      {required int clientId,
      required String Function() readTelegramCode,
      double waitTimeout = waitTimeout}) async {
    await _tdJsonClient.send(clientId, GetAuthorizationState());

    await for (var response in _tdJsonClient
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
          loggy.info('Logged in successfuly');
          break;

        case AuthorizationStateWaitTdlibParameters:
          _tdJsonClient.send(
              clientId,
              SetTdlibParameters(
                  parameters: TdlibParameters(
                api_id: apiId,
                api_hash: apiHash,
                system_language_code: 'en',
                database_directory: databasePath,
                use_message_database: false,
                device_model: 'Desktop',
                application_version: '1.0',
              )));
          break;

        case AuthorizationStateWaitEncryptionKey:
          _tdJsonClient.send(
              clientId, CheckDatabaseEncryptionKey(encryption_key: ''));
          break;

        case AuthorizationStateWaitPhoneNumber:
          _tdJsonClient.send(clientId,
              SetAuthenticationPhoneNumber(phone_number: phoneNumber));
          break;

        case AuthorizationStateWaitCode:
          _tdJsonClient.send(
              clientId, CheckAuthenticationCode(code: readTelegramCode()));

          break;
      }

      if (_isClosed || _isAuthorized) {
        break;
      }
    }
  }

  Stream<dynamic> getChats(
      {required int clientId,
      int limit = 100,
      double waitTimeout = waitTimeout}) async* {
    _tdJsonClient.send(clientId, GetChats(limit: 1000));

    await for (var response in _tdJsonClient
        .receive(waitTimeout: waitTimeout)
        .where((event) =>
            event is UpdateSupergroupFullInfo ||
            event is UpdateBasicGroupFullInfo ||
            event is UpdateUserFullInfo)) {
      yield response;
    }
  }
  
  Stream<dynamic> getMessages(
      {required int clientId, double waitTimeout = waitTimeout}) async* {
    _tdJsonClient.send(clientId, UpdateNewMessage());

    await for (var response in _tdJsonClient
        .receive(waitTimeout: waitTimeout)
        .where((event) => event is UpdateNewMessage)) {
      yield response;
    }
  }

  void execute(dynamic request) {
    _tdJsonClient.execute(request);
  }
}
