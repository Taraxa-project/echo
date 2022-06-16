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

    int readTelegramCode() {
      const String prompt = 'Enter Telegram code:';
      print(prompt);

      while (true) {
        String? inputLine = stdin.readLineSync();
        if (inputLine == null) {
          continue;
        }
        final RegExp exp = RegExp(r"^\d{5}$");
        if (!exp.hasMatch(inputLine)) {
          print('Telegram code must be a five digits number.');
          print(prompt);
          continue;
        }
        return int.parse(inputLine);
      }
    }

    telegramClient.signUp(readTelegramCode);
  }
}
