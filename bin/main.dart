library td_lib;

import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';
import 'dart:convert';
import '../bindings/bindings.dart';

ffi.Pointer client = td_json.client_create();

Object td_execute(Object query) {
  return json.decode(td_json
      .client_execute(client, json.encode(query).toNativeUtf8())
      .toDartString());
}

void td_send(Object query) {
  td_json.client_send(client, json.encode(query).toNativeUtf8());
}

Object td_receive() {
  return json.decode(td_json.client_receive(client, 1.0).toDartString());
}

void main() {
  td_json.client_destroy(client);

  client = td_json.client_create();

  print(td_execute({
    '@type': 'setLogVerbosityLevel',
    'new_verbosity_level': 4,
    '@extra': 1.01234
  }));

  while (true) {
    td_send({'@type': 'getAuthorizationState', '@extra': 1.01234});

    var event = td_receive();

    print(json.encode(event));
  }

  td_json.client_destroy(client);
}
