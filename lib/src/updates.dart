import 'package:telegram_client/telegram_client.dart';
import 'dart:io';

Future<void> handleAuthUpdate(Tdlib client, update, phone) async {
  if (update == "authorizationStateWaitPhoneNumber") {
    print(await client.requestApi("setAuthenticationPhoneNumber", {
      "phone_number": phone,
    }));
  }
  if (update == "authorizationStateWaitCode") {
    print("Code: ");
    stdout.write("Code: ");
    var code = stdin.readLineSync().toString();
    print(await client.requestApi("checkAuthenticationCode", {"code": code}));
  }
  if (update == "authorizationStateReady") {
    print(">>>> Successful login.");
  }
}
