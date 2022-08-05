import 'dart:ffi';
import 'dart:convert';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:logging/logging.dart';
import 'package:td_json_client/td_json_client.dart';

import 'src/lib_td_json.dart';
// import 'api/base.dart';
// import 'api/map.dart';

/// Telegram client for TDLib JSON interface.
class TdJsonClient {
  /// The path to the libtdjson library.
  final String libtdjsonPath;

  /// The libtdjson FFI instance.
  late final LibTdJson _libTdJson;

  TdJsonClient({
    required String this.libtdjsonPath,
    Logger? loggerTdLib,
    Logger? logger,
  }) {
    _libTdJson = LibTdJson(DynamicLibrary.open(libtdjsonPath));

    if (loggerTdLib != null) this.loggerTdLib = loggerTdLib;
    if (logger != null) this.logger = logger;

    // Do not use the default TDLib logger.
    // execute(SetLogStream(log_stream: LogStreamEmpty()));

    execute(SetLogStream(
        log_stream: LogStreamFile(
      path: 'a.log',
      max_file_size: 100000,
      redirect_stderr: false,
    )));

    // Instead redirect the logs to the provided [Logger].
    td_log_message_callback_ptr pointer =
        Pointer.fromFunction(td_set_log_message_callback);
    // _libTdJson.td_set_log_message_callback(
    //   this._loggerTdLib.level.value,
    //   pointer,
    // );
  }

  int create_client_id() {
    var clientId = _libTdJson.td_create_client_id();
    return clientId;
  }

  void execute(TdFunction request) {
    String requestJson = request.toJson();
    _libTdJson.td_execute(requestJson.toNativeUtf8().cast<Char>());
    _libTdJson.td_execute('{"key": "value"}'.toNativeUtf8().cast<Char>());
  }

  Future<void> send(int clientId, TdFunction request) async {
    request.client_id = clientId;

    String requestJson = request.toJson();
    _libTdJson.td_send(clientId, requestJson.toNativeUtf8().cast<Char>());
  }

  dynamic receive({
    double waitTimeout = 1.0,
  }) {
    var tdResponse = _libTdJson.td_receive(waitTimeout);
    if (tdResponse != nullptr) {
      var responseJson = tdResponse.cast<Utf8>().toDartString();

      var td = TdApiMap.fromMap(jsonDecode(responseJson));
      if (td != null) return td;
    }
  }

  /// The TDLib [Logger].
  Logger _loggerTdLib = _loggerStdout('TDLib');

  /// The TDLib [Logger].
  Logger get loggerTdLib => _loggerTdLib;

  /// The TDLib [Logger].
  void set loggerTdLib(Logger logger) {
    if (logger.level.value != _loggerTdLib.level.value) {
      execute(SetLogVerbosityLevel(new_verbosity_level: 5));
    }
    _loggerTdLib = logger;
  }

  /// The TdJsonClient [Logger].
  Logger logger = _loggerStdout('TdJsonClient');

  // Returns a simple [Logger] that prints to stdout.
  static Logger _loggerStdout(String name) {
    final logger = Logger(name);
    logger.level = Level.INFO;
    logger.onRecord.listen((event) {
      print(event);
    });
    return logger;
  }

// // ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Int, ffi.Pointer<ffi.Char>)>>;
  static void td_set_log_message_callback(
      int verbosity_level, Pointer<Char> message) {
    // _loggerTdLib.log(Level('a', verbosity_level), message);
  }
}
