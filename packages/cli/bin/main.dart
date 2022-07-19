import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:loggy/loggy.dart';

import 'package:echo_cli/command/login.dart';

void main(List<String> arguments) {
  Loggy.initLoggy(
      logPrinter: const PrettyPrinter(),
      logOptions: defaultLevel,
      hierarchicalLogging: true);

  final commandRunner =
      CommandRunner("echo", "A dart implementation of Telegram scrapper.");

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
    ..addOption('loglevel', help: 'Log level', defaultsTo: 'Error');

  commandRunner
    ..addCommand(TelegramCommandLogin())
    ..run(arguments).catchError((error) {
      if (error is! UsageException) throw error;
      print(error);
      exit(64);
    });
}
