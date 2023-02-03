import 'dart:io';

import 'package:logging/logging.dart';
import 'package:args/command_runner.dart';

import 'package:echo_cli/command/messages.dart';

void main(List<String> arguments) {
  hierarchicalLoggingEnabled = true;
  Logger.root.level = Level.ALL;

  final CommandRunner commandRunner =
      CommandRunner("echo", "A dart implementation of Telegram scrapper.");

  commandRunner.argParser
    ..addOption(
      'api-id',
      mandatory: true,
      help: 'Telegram api_id (https://my.telegram.org/apps/)',
    )
    ..addOption(
      'api-hash',
      mandatory: true,
      help: 'Telegram api_hash (https://my.telegram.org/apps/)',
    )
    ..addOption(
      'phone-number',
      mandatory: true,
      help: 'Your phone number',
    )
    ..addOption(
      'libtdjson-path',
      mandatory: true,
      help: 'libtdjson path',
    )
    ..addOption(
      'database-path',
      help: 'tdlib database path',
      defaultsTo: 'tdlib',
    )
    ..addOption(
      'message-database-path',
      help: 'message database path',
      defaultsTo: 'message.sqlite',
    )
    ..addOption(
      'loglevel',
      help: 'Log level',
      defaultsTo: 'warning',
    )
    ..addOption(
      'libtdjson-loglevel',
      help: 'libtdjson log level',
      defaultsTo: 'warning',
    )
    ..addOption(
      'run-forever',
      help: 'Set this to true if you want the app to run forever',
      defaultsTo: 'false',
    )
    ..addOption(
      'proxy',
      help: 'Tdlib proxy uri',
      valueHelp: 'scheme://username:password@host:port',
    );

  TelegramCommandMessages telegramCommandMessages = TelegramCommandMessages();
  telegramCommandMessages.argParser.addOption(
    'chats-names',
    mandatory: true,
    help: 'A list of chat names JSON encoded.',
  );

  commandRunner
    ..addCommand(telegramCommandMessages)
    ..run(arguments).catchError((error) {
      if (error is! UsageException) throw error;
      print(error);
      exit(64);
    });
}
