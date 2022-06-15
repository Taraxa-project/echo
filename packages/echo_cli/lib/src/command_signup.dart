import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:telegram_client/telegram_client.dart';

class CommandSignup extends Command {
  final name = 'signup';
  final description = 'Sign up a Telegram account.';

  void run() {
    final TelegramClient telegramClient = TelegramClient(
      libtdjsonPath: globalResults!['libtdjson-path'],
      apiId: int.parse(globalResults!['api-id']),
      apiHash: globalResults!['api-hash'],
      phoneNumber: globalResults!['phone-number'],
    );
    String readTelegramCode() {
      print("Enter Telegram code:");
      String? telegramCode = stdin.readLineSync();
      return telegramCode ?? readTelegramCode();
    }

    telegramClient.signUp(readTelegramCode);
  }
}
