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
      'proxy',
      help: 'Tdlib proxy uri',
      valueHelp: 'scheme://username:password@host:port',
    );

  TelegramCommandMessages telegramCommandMessages = TelegramCommandMessages();
  telegramCommandMessages.argParser
    ..addOption(
      'chats-names',
      mandatory: true,
      help: 'A list of chat names JSON encoded.',
    )
    ..addOption(
      'table-dump-path',
      help: 'table dump path',
      defaultsTo: '.',
    )
    ..addOption(
      'ipfs-cron-schedule',
      help: 'Cron format for scheduling the export to IPFS',
      defaultsTo: '0 8 * * *',
    )
    ..addOption(
      'ipfs-scheme',
      help: 'Ipfs API scheme',
      defaultsTo: 'http',
    )
    ..addOption(
      'ipfs-host',
      help: 'Ipfs API host',
      defaultsTo: 'localhost',
    )
    ..addOption(
      'ipfs-port',
      help: 'Ipfs API port',
      defaultsTo: '5001',
    )
    ..addOption(
      'ipfs-username',
      help: 'Ipfs API username for basic authentication',
    )
    ..addOption(
      'ipfs-password',
      help: 'Ipfs API password for basic authentication',
    )
    ..addOption(
      'run-forever',
      help: 'Set this to true if you want the app to run forever',
      defaultsTo: 'false',
    );

  commandRunner
    ..addCommand(telegramCommandMessages)
    ..run(arguments).catchError((error) {
      if (error is! UsageException) throw error;
      print(error);
      exit(64);
    });
}