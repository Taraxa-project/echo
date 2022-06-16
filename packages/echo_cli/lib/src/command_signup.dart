import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:loggy/loggy.dart';

import 'package:telegram_client/telegram_client.dart';

class CommandSignup extends Command {
  final name = 'signup';
  final description = 'Sign up a Telegram account.';

  void run() {
    var logLevel = LogLevel.values.firstWhere(
        (element) => element.name == globalResults!['loglevel'],
        orElse: () => LogLevel.all);
    var logOptions = LogOptions(logLevel);

    Loggy.initLoggy(logPrinter: const PrettyPrinter(), logOptions: logOptions);

    final TelegramClient telegramClient = TelegramClient(
        libtdjsonPath: globalResults!['libtdjson-path'],
        apiId: int.parse(globalResults!['api-id']),
        apiHash: globalResults!['api-hash'],
        phoneNumber: globalResults!['phone-number'],
        libtdjsonLoglevel: int.parse(globalResults!['libtdjson-loglevel']));

    String readTelegramCode() {
      print("Enter Telegram code:");
      String? telegramCode = stdin.readLineSync();
      return telegramCode ?? readTelegramCode();
    }

    telegramClient.signUp(readTelegramCode);
  }
}
