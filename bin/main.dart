import 'dart:convert';

import 'package:hexaminate/hexaminate.dart';
import 'package:telegram_client/telegram_client.dart';
import 'dart:io';
import 'dart:developer' as developer;

void main() async {
  print('Starting main');
  try {
    var path = Directory.current.path;
    developer.log('Starting main, path: $path');
    var option = {
      'api_id': 1917085,
      'api_hash': 'a612212e6ac3ff1f97a99b2e0f050894',
      'database_directory': "$path/user",
      'files_directory': "$path/user",
    };
    //var tdlibpath = Directory('../dart_api/tdlib/');
    //print(await tdlibpath.list().toList());
    Tdlib tg = Tdlib("/dart_api/tdlib/libtdjson.so", option);
    print('Tdlib initialized');
    tg.on("update", (UpdateTd update) async {
      try {
        print("Update received:  ${update.raw.toString()}");
        if (update.raw["@type"] == "updateAuthorizationState") {
          if (typeof(update.raw["authorization_state"]) == "object") {
            var authStateType = update.raw["authorization_state"]["@type"];
            if (authStateType == "authorizationStateWaitPhoneNumber") {
              // stdout.write("Phone number: ");
              // var phoneNumber = stdin.readLineSync().toString();
              // your phone number here
              var phoneNumber = '';
              print(await tg.requestApi("setAuthenticationPhoneNumber",
                  {"phone_number": phoneNumber}));
            }
            if (authStateType == "authorizationStateWaitCode") {
              print("ada update code");
              stdout.write("Code: ");
              var code = stdin.readLineSync().toString();
              print(await tg
                  .requestApi("checkAuthenticationCode", {"code": code}));
            }
            if (authStateType == "authorizationStateWaitPassword") {
              var code = "Azkariani90";
              print(await tg.requestApi(
                  "checkAuthenticationPassword", {"password": code}));
            }
            if (authStateType == "authorizationStateReady") {
              print("Login success");
            }
          }
        }

        /*
        if (update.message.is_found) {
          if (update.message.text != null) {
            if (!update.message.is_outgoing) {
              const Duration(seconds: 60);
              String username = "@lpmsanbox";
              String message =
                  "Lo pm gk pernah di tap? coba lpm ini\n$username $username $username\n$username $username $username\n$username $username $username\n\nJaseb: @hexaminate";

              try {
                await tg.requestApi("sendMessage", {
                  "chat_id": update.message.chat.id,
                  
                  "reply_to_message_id": update.raw["message"]["id"],
                  
                  "input_message_content": {
                    "@type": "inputMessageText",
                    "text": {
                      "@type": "formattedText",
                      "text": message,
                      "entitiees": []
                    },
                    "disableWebPagePreview": false,
                    "clearDraft": false
                  }
                });
              } catch (e) {}
            }
            if (RegExp("^/ping", caseSensitive: false)
                .hasMatch(update.message.text ?? "")) {
              return await tg.request("sendMessage",
                  {"chat_id": update.message.chat.id, "text": "Pong"});
            }
            if (update.message.text == "/start") {
              return await tg.request("sendMessage", {
                "chat_id": update.message.chat.id,
                "text": "Hello saya adalah bot"
              });
            }
          }
        }*/
      } catch (e) {
        print(e.toString());
      }
    });
    await tg.initIsolate();
    await tg.user();
  } catch (e) {
    print(e.toString());
  }
}
