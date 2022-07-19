import 'dart:ffi' as ffi;
import 'dart:async';
import 'dart:convert' as convert;

import 'package:loggy/loggy.dart';
import 'package:ffi/ffi.dart' as ffi_ext;

import 'src/lib_td_json.dart';
import 'api/base.dart';
import 'api/map.dart';

mixin TdJsonClientLoggy implements LoggyType {
  @override
  Loggy<TdJsonClientLoggy> get loggy =>
      Loggy<TdJsonClientLoggy>('$runtimeType');

  // void setLogLevel(String logLevelName) {
  //   loggy.level = LogOptions(LogLevel.values.firstWhere(
  //       (element) => element.name == logLevelName,
  //       orElse: () => LogLevel.all));
  // }
}

class TdJsonClient with TdJsonClientLoggy {
  final String libtdjsonPath;
  final int libtdjsonLoglevel;

  late final LibTdJson _libTdJson;

  TdJsonClient(
      {required String this.libtdjsonPath,
      int this.libtdjsonLoglevel = 1,
      loglevel = 'Error'}) {
    // setLogLevel(loglevel);

    // loggy.debug('Loading libdtjson from $libtdjsonPath...');
    _libTdJson = LibTdJson(ffi.DynamicLibrary.open(libtdjsonPath));
    // loggy.debug('Loaded libdtjson.');

    // loggy.debug('Setting libtdjson log level to $libtdjsonLoglevel...');
    execute({
      '@type': 'setLogVerbosityLevel',
      'new_verbosity_level': libtdjsonLoglevel
    });
  }

  int create_client_id() {
    // loggy.debug('Creating libdtjson client id...');
    var clientId = _libTdJson.td_create_client_id();
    // loggy.debug('Created libtdjson client id $clientId.');
    return clientId;
  }

  void execute(dynamic request) {
    String requestJson = convert.jsonEncode(request);
    // loggy.info('Executing $requestJson...');
    _libTdJson.td_execute(requestJson.toNativeUtf8().cast<ffi.Char>());
  }

  Future<void> send(int clientId, TdFunction request) async {
    request.client_id = clientId;

    String requestJson = request.toJson();
    // loggy.info('Sending $requestJson from client id $clientId...');
    _libTdJson.td_send(clientId, requestJson.toNativeUtf8().cast<ffi.Char>());
  }

  dynamic receive({
    double waitTimeout = 1.0,
  }) {
    var tdResponse = _libTdJson.td_receive(waitTimeout);
    if (tdResponse != ffi.nullptr) {
      var responseJson = tdResponse.cast<ffi_ext.Utf8>().toDartString();
      // loggy.info('Received $responseJson.');

      var td = TdApiMap.fromMap(convert.jsonDecode(responseJson));
      if (td != null) return td;

      // loggy.error('Could not find td mapping for: $responseJson.');
    }
  }
}
