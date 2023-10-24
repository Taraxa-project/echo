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

  ffi.Pointer<wasm_functype_t> helloTy = wasm_functype_new_0_0(runtime);
  ffi.Pointer<wasmtime_func_t> hello = calloc();

  //TODO: build the callback pointer
  // runtime.wasmtime_func_new(
  //     context, helloTy, helloCallback, ffi.nullptr, ffi.nullptr, hello);

  ffi.Pointer<wasmtime_extern_t> imports = calloc.allocate(1);
  imports.ref.kind = WASMTIME_EXTERN_FUNC;
  imports.ref.of.func = hello.ref;

  ffi.Pointer<wasmtime_instance_t> instance = calloc();
  ffi.Pointer<ffi.Pointer<wasm_trap_t>> instanceNewTrap = calloc();
  final instanceNewError = runtime.wasmtime_instance_new(
      context, module.value, imports, 1, instance, instanceNewTrap);
  if (instanceNewError != ffi.nullptr) {
    throw Exception(
        'Error creating wasmtime instance: $instanceNewError $instanceNewTrap');
  }
  calloc.free(instanceNewTrap);
  calloc.free(instanceNewError);

  final funcName = 'hello';
  final funcNameAscii = ascii.encode(funcName);
  final ffi.Pointer<ffi.Char> funcNameFfi =
      calloc.allocate(funcNameAscii.length);
  for (var i = 0; i < funcNameAscii.length; i++) {
    funcNameFfi.elementAt(i).value = funcNameAscii[i];
  }

  ffi.Pointer<wasmtime_extern> run = calloc();
  final instanceExportGetResult = runtime.wasmtime_instance_export_get(
      context, instance, funcNameFfi, 3, run);
  calloc.free(funcNameFfi);
  if (instanceExportGetResult == false) {
    throw Exception('Error getting wasmtime func $funcName');
  }

  var runFunc =
      ffi.Pointer.fromAddress(run.address + 8).cast<wasmtime_func_t>();

  ffi.Pointer<wasmtime_val_t> params = ffi.nullptr;
  ffi.Pointer<ffi.Pointer<wasm_trap_t>> funcCallTrap = calloc();
  ffi.Pointer<wasmtime_val_t> results = calloc.allocate(1);
  final funcCallError = runtime.wasmtime_func_call(
      context, runFunc, params, 0, results, 0, funcCallTrap);
  if (funcCallError != ffi.nullptr) {
    throw Exception(
        'Error calling wasmtime function: $funcCallError $funcCallTrap');
  }

  calloc.free(funcCallTrap);
  calloc.free(funcCallError);
  calloc.free(params);
  calloc.free(results);

  runtime.wasmtime_module_delete(module.value);
  runtime.wasmtime_store_delete(store);
  runtime.wasm_engine_delete(engine);

  print('done');
}

ffi.Pointer<wasm_functype_t> wasm_functype_new_0_0(Wasmtime runtime) {
  ffi.Pointer<wasm_valtype_vec_t> params = ffi.nullptr;
  ffi.Pointer<wasm_valtype_vec_t> results = ffi.nullptr;
  runtime.wasm_valtype_vec_new_empty(params);
  runtime.wasm_valtype_vec_new_empty(results);
  return runtime.wasm_functype_new(params, results);
}

ffi.Pointer<wasm_trap_t> helloCallback(
    ffi.Pointer<ffi.Void> env,
    ffi.Pointer<wasmtime_caller_t> caller,
    ffi.Pointer<wasmtime_val_t> args,
    ffi.Size nargs,
    ffi.Pointer<wasmtime_val_t> results,
    ffi.Size nresults) {
  print("Calling back...\n");
  print("> Hello World!\n");
  return ffi.nullptr;
}
