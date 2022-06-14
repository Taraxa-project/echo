import 'dart:io' as io;
import 'dart:ffi' as ffi;

// import 'dart:convert' as convert;
// import 'dart:ffi' as ffi;
// import 'package:ffi/ffi.dart' as ffi_ext;

import 'package:telegram_client/src/td_json_client.dart';

class TelegramClient {
  var _tdJsonClient;
  var _tdJsonClientId;

  void connect(int api_id, String api_hash, String phone) {
    this._tdJsonClient =
        TdJsonClient(ffi.DynamicLibrary.open(this._getTdLibPath()));
    this._tdJsonClientId = this._tdJsonClient.td_create_client_id();
  }

  String _getTdLibPath() {
    if (io.Platform.isMacOS) {
      return 'libtdjson.dylib';
    } else if (io.Platform.isWindows) {
      return 'libtdjson.dylib';
    } else {
      return 'libtdjson.so';
    }
  }
}
