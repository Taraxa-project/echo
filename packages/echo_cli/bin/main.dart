import 'dart:io';
import 'package:args/command_runner.dart';

import 'package:echo_cli/src/tg_input.dart';
import 'package:echo_cli/src/tg_command_runner.dart';
import 'package:echo_cli/src/tg_command_signup.dart';

void main(List<String> arguments) {
  final TelegramCommandRunner commandRunner = TelegramCommandRunner(
      "echo", "A dart implementation of Telegram scrapper.");

  commandRunner.argParser
    ..addOption('api-id',
        mandatory: true,
        help: 'Telegram api_id (https://my.telegram.org/apps/)')
    ..addOption('api-hash',
        mandatory: true,
        help: 'Telegram api_hash (https://my.telegram.org/apps/)')
    ..addOption('phone-number', mandatory: true, help: 'Your phone number')
    ..addOption('libtdjson-path', mandatory: true, help: 'libtdjson path')
    ..addOption('libtdjson-loglevel',
        help: 'libtdjson log level', defaultsTo: '1')
    ..addOption('database-path',
        help: 'tdlib database path', defaultsTo: 'tdlib')
    ..addOption('loglevel', help: 'Log level', defaultsTo: 'All');

  commandRunner
    ..readTelegramCode = readTelegramCode
    ..addCommand(CommandSignup())
    ..run(arguments).catchError((error) {
      if (error is! UsageException) throw error;
      print(error);
      exit(64);
    });
}
