import 'package:telegram_client/telegram_client.dart';
import 'dart:io';

Future<void> handleUpdate(Tdlib client, update, payload) async {
  switch (update) {
    case "authorizationStateWaitCode":
      print("Code: ");
      stdout.write("Code: ");
      var code = stdin.readLineSync().toString();
      print(await client.requestApi("checkAuthenticationCode", {"code": code}));
      break;
    case "authorizationStateReady":
      print(">>>> Successful login.");
      break;
    case "updateNewMessage":
      if (payload != null) {
        // TODO: save message here
      }
      break;
    case "updateChatTitle":
      if (payload != null) {
        // TODO: handle chat title change here
      }
      break;
    default:
      break;
  }
}
