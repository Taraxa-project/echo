import 'dart:convert';
import 'package:dotenv/dotenv.dart';
import 'package:hexaminate/hexaminate.dart';
import 'package:telegram_client/src/updates.dart';
import 'package:telegram_client/telegram_client.dart';
import 'dart:io';
import 'dart:developer' as developer;

void main() async {
  final env = DotEnv(includePlatformEnvironment: true)..load();
  try {
    var path = Directory.current.path;
    developer.log('Starting main, path: $path');
    var option = {
      'api_id': env['API_ID'],
      'api_hash': env['API_HASH'],
      'database_directory': "$path/user",
      'files_directory': "$path/user",
    };
    Tdlib tg = Tdlib("/dart_api/tdlib/libtdjson.so", option);
    tg.on("update", (UpdateTd update) async {
      try {
        //print("Update received:  ${update.raw.toString()}");
        switch (update.raw["@type"]) {
          case "updateAuthorizationState":
            if (typeof(update.raw["authorization_state"]) != "object") {
              throw 'ERROR: Invalid update type.';
            }
            final authStateType = update.raw["authorization_state"]["@type"];
            final phone = env['PHONE'];
            if (phone == null || phone.isEmpty) {
              throw 'ERROR: Phone number is empty.';
            }
            await handleAuthUpdate(tg, authStateType, phone);
            break;
          case "updateNewMessage":
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
