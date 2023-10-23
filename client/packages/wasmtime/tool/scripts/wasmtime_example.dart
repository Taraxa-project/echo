import 'dart:convert';
import 'dart:io' as io;
import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:wasmtimme/src/wasmtime.dart';

import 'package:logging/logging.dart';

Map<String, String> envVars = io.Platform.environment;

void main(List<String> arguments) {
  hierarchicalLoggingEnabled = true;
  Logger.root.level = Level.ALL;

  final runtime =
      Wasmtime(ffi.DynamicLibrary.open(envVars['libwasmtime_path']!));

  final wasmEngine = runtime.wasm_engine_new();
  if (wasmEngine == ffi.nullptr) {
    throw Exception('Error creating wasm engine: $wasmEngine');
  }

  var wasmtimeStore =
      runtime.wasmtime_store_new(wasmEngine, ffi.nullptr, ffi.nullptr);
  if (wasmtimeStore == ffi.nullptr) {
    throw Exception('Error creating wasmtime store: $wasmtimeStore');
  }

  final wasmtimeContext = runtime.wasmtime_store_context(wasmtimeStore);
  if (wasmtimeContext == ffi.nullptr) {
    throw Exception('Error creating wasmtime context: $wasmtimeContext');
  }

  final wasmModuleFile = io.File(envVars['wasm_module_path']!);
  final wasmModuleBytes = wasmModuleFile.readAsBytesSync();

  ffi.Pointer<ffi.Uint8> wasmModuleBytesPointer =
      malloc.allocate(wasmModuleBytes.length);
  for (var i = 0; i < wasmModuleBytes.length; i++) {
    wasmModuleBytesPointer.elementAt(i).value = wasmModuleBytes[i];
  }

  ffi.Pointer<ffi.Pointer<wasmtime_module_t>> wasmtimeModule = calloc();
  final wasmtimeModuleNewError = runtime.wasmtime_module_new(wasmEngine,
      wasmModuleBytesPointer, wasmModuleBytes.length, wasmtimeModule);
  if (wasmtimeModuleNewError != ffi.nullptr) {
    throw Exception('Error creating wasmtime module: $wasmtimeModuleNewError');
  }
  calloc.free(wasmModuleBytesPointer);

  ffi.Pointer<wasmtime_instance_t> wasmtimeInstance = calloc();
  ffi.Pointer<ffi.Pointer<wasm_trap_t>> wasmTrapInstanceNew = calloc();
  final wasmtimeInstanceNewError = runtime.wasmtime_instance_new(
      wasmtimeContext,
      wasmtimeModule.elementAt(0).value,
      ffi.nullptr,
      0,
      wasmtimeInstance,
      wasmTrapInstanceNew);
  if (wasmtimeInstanceNewError != ffi.nullptr) {
    throw Exception(
        'Error creating wasmtime instance: $wasmtimeInstanceNewError $wasmTrapInstanceNew');
  }
  calloc.free(wasmTrapInstanceNew);
  calloc.free(wasmtimeInstanceNewError);

  final funcName = 'gcd';
  final funcNameAscii = ascii.encode(funcName);
  final ffi.Pointer<ffi.Char> funcNameFfi = calloc.allocate(3);
  for (var i = 0; i < funcNameAscii.length; i++) {
    funcNameFfi.elementAt(i).value = funcNameAscii[i];
  }

  ffi.Pointer<wasmtime_extern> wasmtimeExtern = calloc();
  final gcdOk = runtime.wasmtime_instance_export_get(
      wasmtimeContext, wasmtimeInstance, funcNameFfi, 3, wasmtimeExtern);
  calloc.free(funcNameFfi);
  if (gcdOk == false) {
    throw Exception('Error getting wasmtime func $funcName');
  }

  var wasmtimeFunc = ffi.Pointer.fromAddress(wasmtimeExtern.address + 8)
      .cast<wasmtime_func_t>();

  final a = 6;
  final b = 27;
  ffi.Pointer<wasmtime_val_t> params = calloc.allocate(2);
  params.elementAt(0).ref.kind = WASMTIME_I32;
  params.elementAt(0).ref.of.i32 = a;
  params.elementAt(1).ref.kind = WASMTIME_I32;
  params.elementAt(1).ref.of.i32 = b;

  ffi.Pointer<ffi.Pointer<wasm_trap_t>> wasmTrapFuncCall = calloc();
  ffi.Pointer<wasmtime_val_t> results = calloc.allocate(1);
  final wasmtimeFuncCallError = runtime.wasmtime_func_call(
      wasmtimeContext, wasmtimeFunc, params, 2, results, 1, wasmTrapFuncCall);
  if (wasmtimeFuncCallError != ffi.nullptr) {
    throw Exception(
        'Error calling wasmtime function: $wasmtimeFuncCallError $wasmTrapFuncCall');
  }
  final result = results[0].of.i32;

  calloc.free(wasmTrapFuncCall);
  calloc.free(wasmtimeFuncCallError);
  calloc.free(params);
  calloc.free(results);

  runtime.wasmtime_module_delete(wasmtimeModule.value);
  runtime.wasmtime_store_delete(wasmtimeStore);
  runtime.wasm_engine_delete(wasmEngine);

  print('gcd of $a and $b is $result');

  // final watModuleFile = io.File(envVars['wat_module_path']!);
  // final wasmModuleBytes = watModuleFile.readAsBytesSync();

  // String s = new String.fromCharCodes(wasmModuleBytes);
  // print(s);

  // ffi.Pointer<ffi.Char> watModulePointer =
  //     malloc.allocate<ffi.Char>(wasmModuleBytes.length);
  // for (var i = 0; i < wasmModuleBytes.length; i++) {
  //   watModulePointer.elementAt(i).value = wasmModuleBytes[i];
  // }

  // for (var i = 0; i < wasmModuleBytes.length; i++) {
  //   io.stdout.write(String.fromCharCode(watModulePointer.elementAt(i).value));
  // }
  // io.stdout.flush();

  // ffi.Pointer<wasmtime_error_t> wasmtimeError = ffi.nullptr;

  // ffi.Pointer<wasm_byte_vec_t> wasm = malloc();
  // wasmtimeError =
  //     runtime.wasmtime_wat2wasm(watModulePointer, wasmModuleBytes.length, wasm);
  // if (wasmtimeError != ffi.nullptr) {
  //   throw Exception('Error compiling wat module: $wasmtimeError');
  // }
  // malloc.free(watModulePointer);
}
