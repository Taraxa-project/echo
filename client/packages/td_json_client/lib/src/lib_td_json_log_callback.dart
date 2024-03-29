// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
import 'dart:ffi' as ffi;

class LibTdJsonLC {
  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  LibTdJsonLC(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  LibTdJsonLC.fromLookup(
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

  int td_create_client_id_lc() {
    return _td_create_client_id_lc();
  }

  late final _td_create_client_id_lcPtr =
      _lookup<ffi.NativeFunction<ffi.Int Function()>>('td_create_client_id_lc');
  late final _td_create_client_id_lc =
      _td_create_client_id_lcPtr.asFunction<int Function()>();

  void td_send_lc(
    int client_id,
    ffi.Pointer<ffi.Char> request,
  ) {
    return _td_send_lc(
      client_id,
      request,
    );
  }

  late final _td_send_lcPtr = _lookup<
          ffi
          .NativeFunction<ffi.Void Function(ffi.Int, ffi.Pointer<ffi.Char>)>>(
      'td_send_lc');
  late final _td_send_lc =
      _td_send_lcPtr.asFunction<void Function(int, ffi.Pointer<ffi.Char>)>();

  ffi.Pointer<ffi.Char> td_receive_lc(
    double timeout,
  ) {
    return _td_receive_lc(
      timeout,
    );
  }

  late final _td_receive_lcPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<ffi.Char> Function(ffi.Double)>>(
          'td_receive_lc');
  late final _td_receive_lc =
      _td_receive_lcPtr.asFunction<ffi.Pointer<ffi.Char> Function(double)>();

  ffi.Pointer<ffi.Char> td_execute_lc(
    ffi.Pointer<ffi.Char> request,
  ) {
    return _td_execute_lc(
      request,
    );
  }

  late final _td_execute_lcPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(
              ffi.Pointer<ffi.Char>)>>('td_execute_lc');
  late final _td_execute_lc = _td_execute_lcPtr
      .asFunction<ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Char>)>();

  void register_log_message_callback_sendport(
    int send_port,
    int max_verbosity_level,
  ) {
    return _register_log_message_callback_sendport(
      send_port,
      max_verbosity_level,
    );
  }

  late final _register_log_message_callback_sendportPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int, ffi.Int)>>(
          'register_log_message_callback_sendport');
  late final _register_log_message_callback_sendport =
      _register_log_message_callback_sendportPtr
          .asFunction<void Function(int, int)>();
}

base class log_message_t extends ffi.Struct {
  @ffi.Int()
  external int verbosity_level;

  external ffi.Pointer<ffi.Char> message;
}
