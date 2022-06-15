import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart' as ffi_ext;
import 'dart:convert' as convert;

import 'package:telegram_client/src/lib_td_json.dart';

class TelegramClient {
  final String libtdjsonPath;

  final int apiId;
  final String apiHash;
  final String phoneNumber;

  late final LibTdJson _libTdJson;
  late final int _tdClientId;

  bool _authorized = false;
  bool _closed = false;

  bool get authorized {
    return _authorized;
  }

  bool get closed {
    return _closed;
  }

  TelegramClient({
    required String this.libtdjsonPath,
    required int this.apiId,
    required String this.apiHash,
    required String this.phoneNumber,
  }) {
    _libTdJson = LibTdJson(ffi.DynamicLibrary.open(libtdjsonPath));
    _tdClientId = _libTdJson.td_create_client_id();
  }

  void signUp(String Function() readTelegramCode) {
    execute({'@type': 'setLogVerbosityLevel', 'new_verbosity_level': 5});
    send({'@type': 'getAuthorizationState'});

    while (true) {
      var response = receive();
      print(response);

      if (response == null) {
        continue;
      }

      switch (response['@type']) {
        case 'updateAuthorizationState':
          switch (response['authorization_state']['@type']) {
            case 'authorizationStateClosed':
              _closed = true;
              break;
            case 'authorizationStateReady':
              _authorized = true;
              break;
            case 'authorizationStateWaitTdlibParameters':
              send({
                '@type': 'setTdlibParameters',
                'parameters': {
                  'api_id': apiId,
                  'api_hash': apiHash,
                  'system_language_code': 'en',
                  'use_message_database': false,
                  'device_model': 'Desktop',
                  'application_version': '1.0',
                }
              });
              break;
            case 'authorizationStateWaitEncryptionKey':
              send({
                '@type': 'checkDatabaseEncryptionKey',
                'encryption_key': '',
              });
              break;
            case 'authorizationStateWaitPhoneNumber':
              send({
                '@type': 'setAuthenticationPhoneNumber',
                'phone_number': phoneNumber,
              });
              break;
            case 'authorizationStateWaitCode':
              send({
                '@type': 'checkAuthenticationCode',
                'code': readTelegramCode(),
              });
              break;
          }
          break;
        default:
      }

      if (_closed || _authorized) {
        break;
      }
    }
  }

  void execute(dynamic request) {
    _libTdJson.td_execute(
        convert.jsonEncode(request).toNativeUtf8().cast<ffi.Char>());
  }

  void send(dynamic request) {
    _libTdJson.td_send(_tdClientId,
        convert.jsonEncode(request).toNativeUtf8().cast<ffi.Char>());
  }

  dynamic receive({double waitTimeout = 10.0}) {
    ffi.Pointer<ffi.Int> tdResponse = _libTdJson.td_receive(waitTimeout);
    if (tdResponse != ffi.nullptr) {
      return convert.jsonDecode(tdResponse.cast<ffi_ext.Utf8>().toDartString());
    }
  }
}
