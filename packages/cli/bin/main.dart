import 'dart:io';

import 'package:logging/logging.dart';
import 'package:args/command_runner.dart';

import 'package:echo_cli/command/example.dart';

void main(List<String> arguments) {
  hierarchicalLoggingEnabled = true;
  Logger.root.level = Level.ALL;

  final CommandRunner commandRunner =
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
    ..addCommand(TelegramCommandExample())
    ..run(arguments).catchError((error) {
      if (error is! UsageException) throw error;
      print(error);
      exit(64);
    });
}
