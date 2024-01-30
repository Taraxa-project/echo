import 'dart:io';

import 'package:logging/logging.dart';
import 'package:args/command_runner.dart';

import 'package:echo_cli/command/messages.dart';
import 'package:echo_cli/command/message.dart';
import 'package:echo_cli/command/wasm.dart';

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

  final telegramSaveChatHistoryCommand = TelegramSaveChatHistoryCommand();
  telegramSaveChatHistoryCommand.argParser
    ..addOption(
      'message-database-path',
      help: 'message database path',
      defaultsTo: 'message.sqlite',
    )
    ..addOption(
      'table-dump-path',
      help: 'table dump path',
      defaultsTo: '.',
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
    )
    ..addOption(
      'config-path',
      help: 'Path to the folder containg wallet.json',
    )
    ..addOption(
      'wallet-private-key',
      help: 'Ingester Wallet private key',
    )
    ..addOption(
      'ingester-contract-address',
      help: 'Ingester contract address',
    )
    ..addOption(
      'ingester-contract-rpc-url',
      help: 'RPC url',
    )
    ..addOption(
      'ingester-contract-max-gas',
      help: 'Ingester contract max gas to use',
      defaultsTo: '25000000',
    )
    ..addOption(
      'dry-run',
      help: 'If true, the main loop does nothing',
      defaultsTo: 'false',
    )
    ..addOption(
      'new-chats-file-name',
      help: 'The file containing the list of new chats to read old messages',
      defaultsTo: 'chats_new.csv',
    );

  final telegramCommandChatMessage = TelegramGetMessageCommand();
  telegramCommandChatMessage.argParser
    ..addOption(
      'chat-name',
      help: 'Chat name',
      defaultsTo: 'taraxa_project',
    )
    ..addOption(
      'message-id',
      help: 'Message id',
      defaultsTo: '1',
    );

  final wasmCommand = WasmCommand();
  wasmCommand.argParser
    ..addOption(
      'libwasmtime_path',
      help: 'libwasmtime path',
    )
    ..addOption(
      'libapiimports_path',
      help: 'lib api imports path',
    )
    ..addOption(
      'wasm_module_path',
      help: 'wasm module path',
    );

  commandRunner
    ..addCommand(telegramSaveChatHistoryCommand)
    ..addCommand(telegramCommandChatMessage)
    ..addCommand(wasmCommand)
    ..run(arguments).catchError((error) {
      if (error is! UsageException) throw error;
      print(error);
      exit(64);
    });
}
