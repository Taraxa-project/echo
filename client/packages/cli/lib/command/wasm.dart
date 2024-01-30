import 'dart:io';
import 'dart:convert';
import 'dart:ffi' as ffi;
import 'dart:async';
import 'dart:isolate';

import 'package:wasmtime/wasmtime.dart';
import 'package:wasmtime/api_imports.dart';

import 'package:args/command_runner.dart';
import 'package:logging/logging.dart';
import 'package:ffi/ffi.dart';

import 'package:telegram_client/log_isolated.dart';
import 'package:telegram_client/db_isolated.dart';
import 'package:telegram_client/exporter_isolated.dart';
import 'package:telegram_client/telegram_client_isolated.dart';

class WasmCommand extends Command {
  final name = 'wasm';
  final description = 'Run a wasm module.';

  void run() async {
    _runWasmModule();
  }

  Future<void> _runWasmModule() async {
    hierarchicalLoggingEnabled = true;
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((event) {
      print(event);
    });

    LogIsolated? log;
    DbIsolated? db;
    TelegramClientIsolated? telegramClient;
    ExporterIsolated? exporter;

    final subscriptionSignalHandler =
        _initSignalHandler(log, db, exporter, telegramClient);

    final libWasmtimePath = globalResults!.command!['libwasmtime_path'];
    final libApiImportsPath = globalResults!.command!['libapiimports_path'];
    final wasmModulePath = globalResults!.command!['wasm_module_path'];

    final runtime = Wasmtime(ffi.DynamicLibrary.open(libWasmtimePath));

    final engine = runtime.wasm_engine_new();
    if (engine == ffi.nullptr) {
      throw Exception('Error creating wasm engine: $engine');
    }

    var store = runtime.wasmtime_store_new(engine, ffi.nullptr, ffi.nullptr);
    if (store == ffi.nullptr) {
      throw Exception('Error creating wasmtime store: $store');
    }

    final context = runtime.wasmtime_store_context(store);
    if (context == ffi.nullptr) {
      throw Exception('Error creating wasmtime context: $context');
    }

    final moduleFile = File(wasmModulePath);
    final moduleBytes = moduleFile.readAsBytesSync();

    ffi.Pointer<ffi.Uint8> modulePointer = malloc.allocate(moduleBytes.length);
    for (var i = 0; i < moduleBytes.length; i++) {
      modulePointer.elementAt(i).value = moduleBytes[i];
    }

    ffi.Pointer<ffi.Pointer<wasmtime_module_t>> module = calloc();
    final moduleNewError = runtime.wasmtime_module_new(
        engine, modulePointer, moduleBytes.length, module);
    if (moduleNewError != ffi.nullptr) {
      throw Exception('Error creating wasmtime module: $moduleNewError');
    }
    calloc.free(modulePointer);

    // ffi.Pointer<wasm_functype_t> apiCallbackTy = wasm_functype_new_0_0(runtime);
    ffi.Pointer<wasm_functype_t> apiCallbackTy =
        wasm_functype_new_1_0(runtime, ffi.nullptr);
    ffi.Pointer<wasmtime_func_t> apiCallback = calloc();

    final libApiImports =
        api_imports(ffi.DynamicLibrary.open(libApiImportsPath));

    if (libApiImports.init_dart_api_dl(ffi.NativeApi.initializeApiDLData) !=
        0) {
      throw Exception('Dart API not initialized');
    }

    final receivePort = ReceivePort();

    final subscription = receivePort.listen((message) {
      var messagePointer = ffi.Pointer<message_t>.fromAddress(message);
      var messageValue = messagePointer.ref;

      Logger.root.shout('${messageValue.message.cast<Utf8>().toDartString()}');

      malloc.free(messagePointer);
    });

    libApiImports.register_callback_sendport(receivePort.sendPort.nativePort);

    final c_apiimports_callback =
        libApiImports.a_callback_Ptr as wasmtime_func_callback_t;
    runtime.wasmtime_func_new(context, apiCallbackTy, c_apiimports_callback,
        ffi.nullptr, ffi.nullptr, apiCallback);

    ffi.Pointer<wasmtime_extern_t> imports =
        calloc.allocate<wasmtime_extern_t>(1);
    imports.ref.kind = WASMTIME_EXTERN_FUNC;
    imports.ref.of.func = apiCallback.ref;

    ffi.Pointer<wasmtime_instance_t> instance = calloc();
    ffi.Pointer<ffi.Pointer<wasm_trap_t>> instanceNewTrap = calloc();
    // final instanceNewError = runtime.wasmtime_instance_new(
    //     context, module.value, ffi.nullptr, 0, instance, instanceNewTrap);
    final instanceNewError = runtime.wasmtime_instance_new(
        context, module.value, imports, 1, instance, instanceNewTrap);
    if (instanceNewError != ffi.nullptr) {
      throw Exception(
          'Error creating wasmtime instance: $instanceNewError $instanceNewTrap');
    }
    calloc.free(instanceNewTrap);
    calloc.free(instanceNewError);

    final funcName = 'run';
    final funcNameAscii = ascii.encode(funcName);
    final ffi.Pointer<ffi.Char> funcNameFfi =
        calloc.allocate(funcNameAscii.length);
    for (var i = 0; i < funcNameAscii.length; i++) {
      funcNameFfi.elementAt(i).value = funcNameAscii[i];
    }

    ffi.Pointer<wasmtime_extern> run = calloc();
    final instanceExportGetResult = runtime.wasmtime_instance_export_get(
        context, instance, funcNameFfi, funcNameAscii.length, run);
    calloc.free(funcNameFfi);
    if (instanceExportGetResult == false) {
      throw Exception('Error getting wasmtime export func $funcName');
    }

    var runFunc =
        ffi.Pointer.fromAddress(run.address + 8).cast<wasmtime_func_t>();

    ffi.Pointer<wasmtime_val_t> params = ffi.nullptr;
    ffi.Pointer<ffi.Pointer<wasm_trap_t>> funcCallTrap = calloc();
    ffi.Pointer<wasmtime_val_t> results = calloc.allocate<wasmtime_val_t>(1);
    final funcCallError = runtime.wasmtime_func_call(
        context, runFunc, params, 0, results, 0, funcCallTrap);
    if (funcCallError != ffi.nullptr) {
      throw Exception(
          'Error calling wasmtime function: $funcCallError $funcCallTrap');
    }

    await Future.delayed(const Duration(seconds: 5));
    await subscription.cancel();
    receivePort.close();

    calloc.free(funcCallTrap);
    calloc.free(funcCallError);
    calloc.free(params);
    calloc.free(results);

    runtime.wasmtime_module_delete(module.value);
    runtime.wasmtime_store_delete(store);
    runtime.wasm_engine_delete(engine);

    subscriptionSignalHandler.cancel();
  }

  StreamSubscription _initSignalHandler(LogIsolated? log, DbIsolated? db,
      ExporterIsolated? exporter, TelegramClientIsolated? telegramClient) {
    return ProcessSignal.sigint.watch().listen((signal) async {
      if ((signal == ProcessSignal.sigint) |
          (signal == ProcessSignal.sigkill)) {
        await _exitIsolates(log, db, exporter, telegramClient);
        exit(0);
      }
    });
  }

  Future<void> _exitIsolates(
      LogIsolated? log,
      DbIsolated? db,
      ExporterIsolated? exporter,
      TelegramClientIsolated? telegramClient) async {
    exporter?.exit();
    await telegramClient?.close();
    await db?.close();
    log?.exit();
  }
}

ffi.Pointer<wasm_functype_t> wasm_functype_new_0_0(Wasmtime runtime) {
  ffi.Pointer<wasm_valtype_vec_t> params = calloc();
  runtime.wasm_valtype_vec_new_empty(params);

  ffi.Pointer<wasm_valtype_vec_t> results = calloc();
  runtime.wasm_valtype_vec_new_empty(results);

  return runtime.wasm_functype_new(params, results);
}

// static inline own wasm_functype_t* wasm_functype_new_1_0(
//   own wasm_valtype_t* p
// ) {
//   wasm_valtype_t* ps[1] = {p};
//   wasm_valtype_vec_t params, results;
//   wasm_valtype_vec_new(&params, 1, ps);
//   wasm_valtype_vec_new_empty(&results);
//   return wasm_functype_new(&params, &results);
// }

ffi.Pointer<wasm_functype_t> wasm_functype_new_1_0(
    Wasmtime runtime, ffi.Pointer<wasm_valtype_t> param0) {
  ffi.Pointer<wasm_valtype_vec_t> params = calloc();
  ffi.Pointer<ffi.Pointer<wasm_valtype_t>> ps =
      calloc.allocate<ffi.Pointer<wasm_valtype_t>>(32);
  // ps.elementAt(0).value = param0;
  // final test = "Yes 😀 !";
  // final testNative = test.toNativeUtf8();
  // ps.elementAt(0).value = testNative.cast<wasm_valtype_t>();

  final ffi.Pointer<ffi.Int32> x = calloc();
  x.value = 12;
  ps.elementAt(0).value = x.cast<wasm_valtype_t>();

  runtime.wasm_valtype_vec_new(params, 1, ps);

  ffi.Pointer<wasm_valtype_vec_t> results = calloc();
  runtime.wasm_valtype_vec_new_empty(results);

  return runtime.wasm_functype_new(params, results);
}
