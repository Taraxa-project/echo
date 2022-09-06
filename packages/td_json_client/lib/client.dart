import 'dart:ffi' as ffi;
import 'dart:async';
import 'dart:convert' as convert;

import 'package:ffi/ffi.dart' as ffi_ext;

import 'src/lib_td_json.dart';
import 'api/base.dart';
import 'api/map.dart';

class TdJsonClient {
  final String libtdjsonPath;
  final int libtdjsonLoglevel;

  late final LibTdJson _libTdJson;

  TdJsonClient(
      {required String this.libtdjsonPath,
      int this.libtdjsonLoglevel = 1,
      loglevel = 'Error'}) {
    _libTdJson = LibTdJson(ffi.DynamicLibrary.open(libtdjsonPath));

    execute({
      '@type': 'setLogVerbosityLevel',
      'new_verbosity_level': libtdjsonLoglevel
    });
  }

  int create_client_id() {
    var clientId = _libTdJson.td_create_client_id();
    return clientId;
  }

  void execute(dynamic request) {
    String requestJson = convert.jsonEncode(request);
    _libTdJson.td_execute(requestJson.toNativeUtf8().cast<ffi.Char>());
  }

  Future<void> send(int clientId, TdFunction request) async {
    request.client_id = clientId;

    String requestJson = request.toJson();
    _libTdJson.td_send(clientId, requestJson.toNativeUtf8().cast<ffi.Char>());
  }

  dynamic receive({
    double waitTimeout = 1.0,
  }) {
    var tdResponse = _libTdJson.td_receive(waitTimeout);
    if (tdResponse != ffi.nullptr) {
      var responseJson = tdResponse.cast<ffi_ext.Utf8>().toDartString();

      var td = TdApiMap.fromMap(convert.jsonDecode(responseJson));
      if (td != null) return td;
    }
  }
}
