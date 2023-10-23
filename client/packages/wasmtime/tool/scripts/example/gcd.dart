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

  final moduleFile = io.File(envVars['wasm_module_path']!);
  final moduleBytes = moduleFile.readAsBytesSync();

  ffi.Pointer<ffi.Uint8> modulePointer = calloc.allocate(moduleBytes.length);
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

  ffi.Pointer<wasmtime_instance_t> instance = calloc();
  ffi.Pointer<ffi.Pointer<wasm_trap_t>> instanceNewTrap = calloc();
  final instanceNewError = runtime.wasmtime_instance_new(
      context, module.value, ffi.nullptr, 0, instance, instanceNewTrap);
  if (instanceNewError != ffi.nullptr) {
    throw Exception(
        'Error creating wasmtime instance: $instanceNewError $instanceNewTrap');
  }
  calloc.free(instanceNewTrap);
  calloc.free(instanceNewError);

  final funcName = 'gcd';
  final funcNameAscii = ascii.encode(funcName);
  final ffi.Pointer<ffi.Char> funcNamePointer =
      calloc.allocate(funcNameAscii.length);
  for (var i = 0; i < funcNameAscii.length; i++) {
    funcNamePointer.elementAt(i).value = funcNameAscii[i];
  }

  ffi.Pointer<wasmtime_extern> gcd = calloc();
  final instanceExportGetResult = runtime.wasmtime_instance_export_get(
      context, instance, funcNamePointer, 3, gcd);
  calloc.free(funcNamePointer);
  if (instanceExportGetResult == false) {
    throw Exception('Error getting wasmtime func $funcName');
  }

  var gcdFunc =
      ffi.Pointer.fromAddress(gcd.address + 8).cast<wasmtime_func_t>();

  final a = 6;
  final b = 27;
  ffi.Pointer<wasmtime_val_t> params = calloc.allocate(2);
  params.elementAt(0).ref.kind = WASMTIME_I32;
  params.elementAt(0).ref.of.i32 = a;
  params.elementAt(1).ref.kind = WASMTIME_I32;
  params.elementAt(1).ref.of.i32 = b;

  ffi.Pointer<ffi.Pointer<wasm_trap_t>> funcCallTrap = calloc();
  ffi.Pointer<wasmtime_val_t> results = calloc.allocate(1);
  final funcCallError = runtime.wasmtime_func_call(
      context, gcdFunc, params, 2, results, 1, funcCallTrap);
  if (funcCallError != ffi.nullptr) {
    throw Exception(
        'Error calling wasmtime function: $funcCallError $funcCallTrap');
  }
  final result = results[0].of.i32;

  calloc.free(funcCallTrap);
  calloc.free(funcCallError);
  calloc.free(params);
  calloc.free(results);

  runtime.wasmtime_module_delete(module.value);
  runtime.wasmtime_store_delete(store);
  runtime.wasm_engine_delete(engine);

  print('gcd of $a and $b is $result');
}
