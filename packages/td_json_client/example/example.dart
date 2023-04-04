import 'package:logging/logging.dart';
import 'package:td_json_client/td_json_client.dart';
import 'package:td_json_client/td_api.dart';

void main() async {
  final _tdJsonClient = TdJsonClient(libtdjsonlcPath: 'path/to/libtdjsonlc');
  final _tdJsonClientId = _tdJsonClient.create_client_id();

  hierarchicalLoggingEnabled = true;

  final loggerTdJsonClient = Logger('TdJsonClient');
  loggerTdJsonClient.level = Level.ALL;
  loggerTdJsonClient.onRecord.listen((event) {
    print(event);
  });
  _tdJsonClient.logger = loggerTdJsonClient;

  final loggerLibTdJson = Logger('LibTdJson');
  loggerLibTdJson.level = Level.WARNING;
  loggerLibTdJson.onRecord.listen((event) {
    print(event);
  });
  _tdJsonClient.loggerTdLib = loggerLibTdJson;

  _tdJsonClient.send(_tdJsonClientId, GetAuthorizationState());
  while (true) {
    var event = _tdJsonClient.receive(waitTimeout: 10);

    if (event is UpdateAuthorizationState) {
      if (event.authorization_state is AuthorizationStateWaitTdlibParameters) {
        _tdJsonClient.send(
            _tdJsonClientId,
            SetTdlibParameters(
              api_hash: '<api_hash>',
              // ...
            ));
      } else if (event.authorization_state
          is AuthorizationStateWaitPhoneNumber) {
        _tdJsonClient.send(
            _tdJsonClientId,
            SetAuthenticationPhoneNumber(
              phone_number: '<phone_number>',
            ));
      }
      // ...
    }

    await Future.delayed(const Duration(milliseconds: 50));
  }
}
