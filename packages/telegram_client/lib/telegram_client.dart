import 'dart:io' as io;
import 'dart:ffi' as ffi;
// import 'package:ffi/ffi.dart' as ffi_ext;
// import 'dart:convert' as convert;

import 'package:telegram_client/src/lib_td_json.dart';

class TelegramClient {
  late final LibTdJson _libTdJson;
  late final ffi.Pointer<ffi.Int> _tdJsonClient;

  void connect(int api_id, String api_hash, String phone) {
    this._libTdJson = LibTdJson(ffi.DynamicLibrary.open(this._getTdLibPath()));
    this._tdJsonClient = this._libTdJson.td_json_client_create();
  }

  void disconnect() {
    this._libTdJson.td_json_client_destroy(this._tdJsonClient.cast<ffi.Void>());
  }

  String _getTdLibPath() {
    if (io.Platform.isMacOS) {
      return 'libtdjson.dylib';
    } else if (io.Platform.isWindows) {
      return 'libtdjson.dll';
    } else {
      return 'libtdjson.so';
    }
  }
}
