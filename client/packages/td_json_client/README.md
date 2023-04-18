## Telegram client for TDLib JSON interface

**td_json_client** is a Dart library that provides binding for the TDLib JSON interface via FFI.
It comes with a simple Telegram client and classes for the Telegram API (version 1.8.10).

Because you cannot invoke native callback outside an isolate this library wraps TDLib (libtdjson)
into antoher library (libtdjsonlc). The libtdjson logs are sent to the Dart thread via a SendPort.

Due to the size limitation of packages on [pub.dev](https://pub.dev), the documentation for the TdLib API classes is not generated.
To generate it locally, remove the nodoc options from `dartdoc_options.yaml`, run `dart doc .` and 
`dhttpd --path doc/api` and access it at [localhost:8080](http://localhost:8080).

## Example

See `example/example.dart`.

```dart
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
              api_hash: 'your_api_hash',
              // ...
            ));
      } else if (event.authorization_state
          is AuthorizationStateWaitPhoneNumber) {
        _tdJsonClient.send(
            _tdJsonClientId,
            SetAuthenticationPhoneNumber(
              phone_number: 'your_phone_number',
            ));
      }
      // ...
    }

    await Future.delayed(const Duration(milliseconds: 50));
  }
}
```

## Build libtdjson and libtdjsonlc

```sh
mkdir -p build/out && \
cd build && \
cmake -DCMAKE_INSTALL_PREFIX:PATH=`pwd`/out ../lib/src/log_callback
cmake --build . --target install
```