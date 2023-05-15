import 'dart:convert';
import 'dart:ffi';
import 'dart:isolate';

import 'package:ffi/ffi.dart';
import 'package:logging/logging.dart';

import 'td_api.dart';
import 'src/td_api/log_level_map.dart';
import 'src/lib_td_json_log_callback.dart';

/// Telegram client for TDLib JSON interface.
class TdJsonClient {
  /// The path to the libtdjson library.
  final String libtdjsonlcPath;

  /// The libtdjson FFI instance.
  late final LibTdJsonLC _libTdJson;

  TdJsonClient({
    required String this.libtdjsonlcPath,
  }) {
    _libTdJson = LibTdJsonLC(DynamicLibrary.open(libtdjsonlcPath));
    if (_libTdJson.init_dart_api_dl(NativeApi.initializeApiDLData) != 0) {
      throw LibTdJsonLCNotInitialized();
    }
  }

  /// Create a TDLib client id
  int create_client_id() {
    return _libTdJson.td_create_client_id_lc();
  }

  /// Executes a synchronous TDLib request
  void execute(TdFunction request) {
    final requestJson = request.toJson();
    logger?.finer({"method": "execute", "value": "$requestJson"});
    _libTdJson.td_execute_lc(requestJson.toNativeUtf8().cast<Char>());
  }

  /// Sends an asynchronous TDLib request
  void send(int clientId, TdFunction request) {
    final requestJson = request.toJson();
    logger?.finer({"method": "send", "value": "$requestJson"});
    _libTdJson.td_send_lc(clientId, requestJson.toNativeUtf8().cast<Char>());
  }

  /// Receives the next Telegram event
  Td? receive({
    double waitTimeout = 1.0,
  }) {
    final tdResponse = _libTdJson.td_receive_lc(waitTimeout);
    if (tdResponse == nullptr) return null;

    final responseJson = tdResponse.cast<Utf8>().toDartString();
    logger?.finer({"method": "receive", "value": "$responseJson"});

    final responseDecoded = jsonDecode(responseJson);

    final response = TdApiMap.fromMap(responseDecoded);
    if (response == null) throw LibTdJsonLCUnknownResponse(responseDecoded);

    return response;
  }

  /// The TdJsonClient [Logger].
  Logger? logger;

  /// TDLib sends logs to this port.
  ReceivePort? _receivePort;

  /// The TDLib [Logger].
  Logger? _loggerTdLib;

  /// The TDLib [Logger].
  Logger? get loggerTdLib => _loggerTdLib;

  void set loggerTdLib(Logger? logger) {
    if (logger?.level.value != _loggerTdLib?.level.value) {
      execute(SetLogVerbosityLevel(
        new_verbosity_level: LogLevelMap.MAP.toTd(logger?.level),
      ));
    }

    // Do not use the default TDLib logger.
    execute(SetLogStream(log_stream: LogStreamEmpty()));

    _receivePort?.close();

    _loggerTdLib = logger;
    if (_loggerTdLib == null) return;

    _receivePort = ReceivePort();

    _receivePort?.listen((message) {
      var logMessagePointer = Pointer<log_message_t>.fromAddress(message);
      var logMessage = logMessagePointer.ref;

      _loggerTdLib?.log(
        LogLevelMap.MAP.fromTd(logMessage.verbosity_level),
        {
          "method": "log_callback",
          "value": "${logMessage.message.cast<Utf8>().toDartString()}"
        },
      );

      malloc.free(logMessage.message);
      malloc.free(logMessagePointer);
    });

    _libTdJson.register_log_message_callback_sendport(
      _receivePort!.sendPort.nativePort,
      LogLevelMap.MAP.toTd(loggerTdLib!.level),
    );
  }

  /// Closes the log receive port.
  void exit() {
    _receivePort?.close();
  }
}

/// Base TDJsonClient exception
abstract class TdJsonClientException implements Exception {}

/// Could not initialize Dart API DL
class LibTdJsonLCNotInitialized extends TdJsonClientException {}

/// Could not map response to generated API
class LibTdJsonLCUnknownResponse extends TdJsonClientException {
  final String response;
  LibTdJsonLCUnknownResponse(this.response);
}
