// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
// ignore_for_file: type=lint
import 'dart:ffi' as ffi;

class api_imports {
  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  api_imports(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  api_imports.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  int init_dart_api_dl(
    ffi.Pointer<ffi.Void> data,
  ) {
    return _init_dart_api_dl(
      data,
    );
  }

  late final _init_dart_api_dlPtr =
      _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
          'init_dart_api_dl');
  late final _init_dart_api_dl =
      _init_dart_api_dlPtr.asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  ffi.Pointer<ffi.Int> callback(
    ffi.Pointer<ffi.Void> env,
    ffi.Pointer<ffi.Int> caller,
    ffi.Pointer<ffi.Int> args,
    int nargs,
    ffi.Pointer<ffi.Int> results,
    int nresults,
  ) {
    return a_callback(
      env,
      caller,
      args,
      nargs,
      results,
      nresults,
    );
  }

  late final a_callback_Ptr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Int> Function(
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Int>,
              ffi.Pointer<ffi.Int>,
              ffi.Int,
              ffi.Pointer<ffi.Int>,
              ffi.Int)>>('callback');
  late final a_callback = a_callback_Ptr.asFunction<
      ffi.Pointer<ffi.Int> Function(ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Int>,
          ffi.Pointer<ffi.Int>, int, ffi.Pointer<ffi.Int>, int)>();

  void register_callback_sendport(
    int send_port,
  ) {
    return _register_callback_sendport(
      send_port,
    );
  }

  late final _register_callback_sendportPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int)>>(
          'register_callback_sendport');
  late final _register_callback_sendport =
      _register_callback_sendportPtr.asFunction<void Function(int)>();
}

final class message_t extends ffi.Struct {
  external ffi.Pointer<ffi.Char> message;
}
