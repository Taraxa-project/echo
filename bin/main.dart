// ignore_for_file: unused_local_variable

import 'dart:io';
import 'package:telegram_client/telegram_client.dart';

void main() async {
  String path = Directory.current.path;
  var option = {
    'api_id': 7230930,
    'api_hash': '4e23bcf61a861db95806c819551e3937',
    'database_directory': "$path/bost",
    'files_directory': "$path/bost",
  };
  print(option.containsKey("api_id"));
  Map<String, dynamic> _optionTdlibDefault = {
    '@type': 'tdlibParameters',
    'api_id': 7230930,
    'api_hash': '4e23bcf61a861db95806c819551e3937',
    'database_directory': "",
    'files_directory': "",
    "use_file_database": true,
    "use_chat_info_database": true,
    "use_message_database": true,
    "use_secret_chats": true,
    'enable_storage_optimizer': true,
    'system_language_code': 'en',
    'new_verbosity_level': 0,
    'application_version': 'v1',
    'device_model': 'Telegram Client Hexaminate',
    'system_version': Platform.operatingSystem,
    "database_key": "",
    "start": true
  };
  Tdlib tg = Tdlib("/dart_api/tdlib/libtdjson.so", option);
  tg.on("update", (UpdateTd update) async {
    if (update.raw["@extra"] != null) {}
    print(update.raw);
    if (update.message.is_found) {
      if (update.message.text != null) {
        if (update.message.text!.isNotEmpty) {}
        if (RegExp("^/ping", caseSensitive: false)
            .hasMatch(update.message.text ?? "")) {
          tg.requestSendApi(
              "sendMessage",
              tg.makeParameters("sendMessage", {
                "chat_id": update.message.chat.id,
                "text": "Hello from Dart"
              }));
        }
        if (update.message.text == "/stop") {
          tg.stop();
        }
      }
    }
/*
    if (updateOrigin["@type"] == "updateAuthorizationState") {
      var authState = updateOrigin["authorization_state"];

      if (typeData(authState) == "object") {
        if (authState["@type"] == "authorizationStateWaitTdlibParameters") {
          var optin = {
            "@type": 'setTdlibParameters',
            'parameters': _optionTdlibDefault
          };

          tg.requestApi("setTdlibParameters", optin);
        }
        if (authState["@type"] == "authorizationStateWaitEncryptionKey") {
          /*
          tg.requestApi("checkDatabaseEncryptionKey",
              {'encryption_key': _optionTdlibDefault["database_key"]});
              */
        }
      }
    }
    if (updateOrigin["@type"] == "updateConnectionState" &&
        updateOrigin["state"]["@type"] == "connectionStateReady") {
      /*
      tg.requestApi("checkAuthenticationBotToken",
          {"token": "2123043767:AAEY0KTdVYo0JTRmFF5S4QPBnvoCdpe2yPI"});
    
    */
      print(updateOrigin);
    }
    */
  });
  tg.initIsolate();
  /*
  tg.on("update", (UpdateTd update) async {
    if (update.message.is_found) {
      if (update.message.text != null) {
        if (update.message.text!.isNotEmpty) {}
        if (RegExp("^/ping", caseSensitive: false)
            .hasMatch(update.message.text ?? "")) {
          tg.emitter.emit("update", null, {"@type": "azka"});
          return await tg.request("sendMessage",
              {"chat_id": update.message.chat.id, "text": "Pong!!"});
        }
        if (update.message.text == "/start") {
          return await tg.request("sendMessage", {
            "chat_id": update.message.chat.id,
            "text": "Hello saya adalah bot"
          });
        }
      }
    }
  });
  await tg.bot("2123043767:AAEY0KTdVYo0JTRmFF5S4QPBnvoCdpe2yPI");
  */
  await tg.bot("2123043767:AAEY0KTdVYo0JTRmFF5S4QPBnvoCdpe2yPI");
  print("update");
}
