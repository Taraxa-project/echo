import 'dart:convert';
import 'package:dotenv/dotenv.dart';
import 'package:hexaminate/hexaminate.dart';
import '../sl_td_lib/telegram_client.dart';
import '../sl_td_lib/src/updates.dart';
import 'dart:io';
import 'dart:developer' as developer;

void main() async {
  final env = DotEnv(includePlatformEnvironment: true);
  try {
    var path = Directory.current.path;
    developer.log('Starting main, path: $path');
    var option = {
      'api_id': env['API_ID'],
      'api_hash': env['API_HASH'],
      'database_directory': "$path/user",
      'files_directory': "$path/user",
    };
    Tdlib tg = Tdlib(env['PATH_TD_JSON_LIB'].toString(), option);
    tg.on("update", (UpdateTd update) async {
      try {
        //print("Update received:  ${update.raw.toString()}");
        final updateType = update.raw["@type"];
        switch (updateType) {
          case "updateAuthorizationState":
            if (typeof(update.raw["authorization_state"]) != "object") {
              throw 'ERROR: Invalid update type.';
            }
            final authStateType = update.raw["authorization_state"]["@type"];
            final phone = env['PHONE'];
            if (phone == null || phone.isEmpty) {
              throw 'ERROR: Phone number is empty.';
            }
            if (authStateType == "authorizationStateWaitPhoneNumber") {
              print(await tg.requestApi("setAuthenticationPhoneNumber", {
                "phone_number": phone,
              }));
            }
            await handleUpdate(tg, authStateType, null);
            break;
          case "updateNewMessage":
            print("Message received:  ${update.raw.toString()}");
            final payload = update.raw["message"];
            await handleUpdate(tg, updateType, payload);
            break;
          case "updateChatTitle":
            final payload = {
              "chat_id": update.raw["chat_id"],
              "title": update.raw["title"]
            };
            await handleUpdate(tg, updateType, payload);
            break;
          default:
            break;
        }
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
