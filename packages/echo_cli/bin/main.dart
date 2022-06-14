// import 'dart:io' as io;
import 'package:echo_cli/telegram_config.dart' as telegram_config;

import 'package:telegram_client/telegram_client.dart';

void main() {
  final telegramClient = TelegramClient();
  telegramClient.connect(telegram_config.getApiId(),
      telegram_config.getApiHash(), telegram_config.getPhoneNumber());

//   final tdJsonLib = TdJsonClient(ffi.DynamicLibrary.open(_getPathTdJsonLib()));
//   final tdJsonClientId = tdJsonLib.td_create_client_id();

//   dynamic request = {'@type': 'getAuthorizationState', '@extra': 'some-hash'};
//   tdJsonLib.td_send(tdJsonClientId,
//       convert.jsonEncode(request).toNativeUtf8().cast<ffi.Char>());

//   bool connected = false;
//   bool done = false;

//   const waitTimeout = 10.0;

//   while (true) {
//     ffi.Pointer<ffi.Int> tdResponse = tdJsonLib.td_receive(waitTimeout);

//     if (tdResponse != ffi.nullptr) {
//       var response =
//           convert.jsonDecode(tdResponse.cast<ffi_ext.Utf8>().toDartString());

//       if (response['@type'] == 'updateAuthorizationState') {
//         var authorization_state = response['authorization_state'];

//         if (authorization_state['@type'] == 'authorizationStateClosed') {
//           break;
//         }

//         if (authorization_state['@type'] ==
//             'authorizationStateWaitTdlibParameters') {
//           request = {
//             '@type': 'setTdlibParameters',
//             'parameters': {
//               'api_id': _getApiId(),
//               'api_hash': _getApiHash(),
//               'system_language_code': 'en',
//               'use_message_database': false,
//               'device_model': 'Desktop',
//               'application_version': '1.0',
//             }
//           };
//           tdJsonLib.td_send(tdJsonClientId,
//               convert.jsonEncode(request).toNativeUtf8().cast<ffi.Char>());
//         }

//         if (authorization_state['@type'] ==
//             'authorizationStateWaitTdlibParameters') {
//           request = {
//             '@type': 'checkDatabaseEncryptionKey',
//             'encryption_key': '',
//           };
//           tdJsonLib.td_send(tdJsonClientId,
//               convert.jsonEncode(request).toNativeUtf8().cast<ffi.Char>());
//         }

//         if (authorization_state['@type'] ==
//             'authorizationStateWaitPhoneNumber') {
//           request = {
//             '@type': 'setAuthenticationPhoneNumber',
//             'phone_number': _getPhoneNumber(),
//           };
//           tdJsonLib.td_send(tdJsonClientId,
//               convert.jsonEncode(request).toNativeUtf8().cast<ffi.Char>());
//         }

//         if (authorization_state['@type'] == 'authorizationStateReady') {
//           connected = true;
//         }
//       } else if (response['@type'] == 'updateNewMessage') {
//         print('New Message\n');
//         print(response);
//       } else {
//         print(response);
//       }
//     }

//     if (connected == true) {
//       if (done == false) {
//         request = {
//           '@type': 'getChats',
//         };
//         tdJsonLib.td_send(tdJsonClientId,
//             convert.jsonEncode(request).toNativeUtf8().cast<ffi.Char>());
//         done = true;
//       }
//     }
//   }
}
