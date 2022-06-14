import 'dart:io' as io;
import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart' as ffi_ext;
import 'dart:convert' as convert;

import 'package:telegram_client/src/lib_td_json.dart';

class TelegramClient {
  late final LibTdJson _libTdJson;
  late final ffi.Pointer<ffi.Int> _tdJsonClient;

  void connect(int apiId, String apiHash, String phoneNumber) {
    this._libTdJson = LibTdJson(ffi.DynamicLibrary.open(this._getTdLibPath()));
    this._tdJsonClient = this._libTdJson.td_json_client_create();

    dynamic request;
    const double waitTimeout = 10.0;

    while (true) {
      ffi.Pointer<ffi.Int> tdResponse = this._libTdJson.td_json_client_receive(
          this._tdJsonClient.cast<ffi.Void>(), waitTimeout);

      if (tdResponse != ffi.nullptr) {
        var response =
            convert.jsonDecode(tdResponse.cast<ffi_ext.Utf8>().toDartString());

        if (response['@type'] == 'updateAuthorizationState') {
          var authorization_state = response['authorization_state'];

          if (authorization_state['@type'] == 'authorizationStateClosed') {
            break;
          }

          if (authorization_state['@type'] ==
              'authorizationStateWaitTdlibParameters') {
            request = {
              '@type': 'setTdlibParameters',
              'parameters': {
                'api_id': apiId,
                'api_hash': apiHash,
                'system_language_code': 'en',
                'use_message_database': false,
                'device_model': 'Desktop',
                'application_version': '1.0',
              }
            };
            this._libTdJson.td_json_client_send(
                this._tdJsonClient.cast<ffi.Void>(),
                convert.jsonEncode(request).toNativeUtf8().cast<ffi.Char>());
          }

          if (authorization_state['@type'] ==
              'authorizationStateWaitTdlibParameters') {
            request = {
              '@type': 'checkDatabaseEncryptionKey',
              'encryption_key': '',
            };
            this._libTdJson.td_json_client_send(
                this._tdJsonClient.cast<ffi.Void>(),
                convert.jsonEncode(request).toNativeUtf8().cast<ffi.Char>());
          }

          if (authorization_state['@type'] ==
              'authorizationStateWaitPhoneNumber') {
            request = {
              '@type': 'setAuthenticationPhoneNumber',
              'phone_number': phoneNumber,
            };
            this._libTdJson.td_json_client_send(
                this._tdJsonClient.cast<ffi.Void>(),
                convert.jsonEncode(request).toNativeUtf8().cast<ffi.Char>());
          }

          if (authorization_state['@type'] == 'authorizationStateReady') {
            break;
          }
        }
      }
    }
  }

  int disconnect() {
    return this
        ._libTdJson
        .td_json_client_destroy(this._tdJsonClient.cast<ffi.Void>());
  }

  String _getTdLibPath() {
    if (io.Platform.isMacOS) {
      return 'libtdjson.dylib';
    } else if (io.Platform.isWindows) {
      return 'libtdjson.dll';
    } else {
      return 'libtdjson.so';
    }
  }
}
