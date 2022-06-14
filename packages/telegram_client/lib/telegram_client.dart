import 'dart:io' as io;
import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart' as ffi_ext;
import 'dart:convert' as convert;

import 'package:telegram_client/src/lib_td_json.dart';

class TelegramClient {
  final int _apiId;
  final String _apiHash;
  final String _phoneNumber;

  late final LibTdJson _libTdJson;
  late final int _tdClientId;

  TelegramClient(
      int this._apiId, String this._apiHash, String this._phoneNumber) {
    _libTdJson = LibTdJson(ffi.DynamicLibrary.open(_getTdLibPath()));
    _tdClientId = this._libTdJson.td_create_client_id();
  }

  void signUp() {
    dynamic request;
    const double waitTimeout = 10.0;

    while (true) {
      ffi.Pointer<ffi.Int> tdResponse = _libTdJson.td_receive(waitTimeout);
      if (tdResponse == ffi.nullptr) {
        continue;
      }
      var response =
          convert.jsonDecode(tdResponse.cast<ffi_ext.Utf8>().toDartString());
      switch (response['@type']) {
        case 'updateAuthorizationState':
          switch (response['authorization_state']) {
            case 'authorizationStateClosed':
              break;
            case 'authorizationStateReady':
              break;
          }
          break;
        default:
      }

      //   if (tdResponse != ffi.nullptr) {
      //     var response =
      //         convert.jsonDecode(tdResponse.cast<ffi_ext.Utf8>().toDartString());

      //     if (response['@type'] == 'updateAuthorizationState') {
      //       var authorization_state = response['authorization_state'];

      //       if (authorization_state['@type'] == 'authorizationStateClosed') {
      //         break;
      //       }

      //       if (authorization_state['@type'] ==
      //           'authorizationStateWaitTdlibParameters') {
      //         request = {
      //           '@type': 'setTdlibParameters',
      //           'parameters': {
      //             'api_id': apiId,
      //             'api_hash': apiHash,
      //             'system_language_code': 'en',
      //             'use_message_database': false,
      //             'device_model': 'Desktop',
      //             'application_version': '1.0',
      //           }
      //         };
      //         this._libTdJson.td_json_client_send(
      //             this._tdJsonClient.cast<ffi.Void>(),
      //             convert.jsonEncode(request).toNativeUtf8().cast<ffi.Char>());
      //       }

      //       if (authorization_state['@type'] ==
      //           'authorizationStateWaitTdlibParameters') {
      //         request = {
      //           '@type': 'checkDatabaseEncryptionKey',
      //           'encryption_key': '',
      //         };
      //         this._libTdJson.td_json_client_send(
      //             this._tdJsonClient.cast<ffi.Void>(),
      //             convert.jsonEncode(request).toNativeUtf8().cast<ffi.Char>());
      //       }

      //       if (authorization_state['@type'] ==
      //           'authorizationStateWaitPhoneNumber') {
      //         request = {
      //           '@type': 'setAuthenticationPhoneNumber',
      //           'phone_number': phoneNumber,
      //         };
      //         this._libTdJson.td_json_client_send(
      //             this._tdJsonClient.cast<ffi.Void>(),
      //             convert.jsonEncode(request).toNativeUtf8().cast<ffi.Char>());
      //       }

      //       if (authorization_state['@type'] == 'authorizationStateReady') {
      //         break;
      //       }
      //     }
      //   }
    }
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
