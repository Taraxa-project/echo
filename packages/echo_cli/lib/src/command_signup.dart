import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:loggy/loggy.dart';

import 'package:telegram_client/telegram_client.dart';

class CommandSignup extends Command {
  final name = 'signup';
  final description = 'Sign up a Telegram account.';

  void run() async {
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
      final RegExp fiveDigitsRegExp = RegExp(r"^\d{5}$");
      while (true) {
        print('Enter Telegram code:');
        String inputLine = stdin.readLineSync() ?? '';
        if (fiveDigitsRegExp.hasMatch(inputLine)) {
          return inputLine;
        }
        print('Telegram code must be a five digits number.');
      }
    }

    await telegramClient.signUp(readTelegramCode);
    if (telegramClient.isAuthorized) {
      print('Signed up successfully.');
    }
    if (telegramClient.isClosed) {
      print('Server closed connection.');
    }
  }
}
