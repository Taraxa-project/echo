import 'dart:io';
import 'dart:async';

import 'package:path/path.dart' as p;
import 'package:args/command_runner.dart';
import 'package:logging/logging.dart';

import 'package:echo_cli/callback/cli.dart';
import 'package:telegram_client/log_isolated.dart';
import 'package:telegram_client/db_isolated.dart';
import 'package:telegram_client/exporter_interface.dart';
import 'package:telegram_client/exporter_isolated.dart';
import 'package:telegram_client/telegram_client_interface.dart';
import 'package:telegram_client/telegram_client_isolated.dart';
import 'package:telegram_client/ingester_contract.dart';

class TelegramSaveChatHistoryCommand extends Command {
  final name = 'messages';
  final description = 'Read and save messages from the last two weeks.';

  void run() async {
    _saveChatsHistory();
  }

  Future<void> _saveChatsHistory() async {
    hierarchicalLoggingEnabled = true;

    LogIsolated? log;
    DbIsolated? db;
    TelegramClientIsolated? telegramClient;
    ExporterIsolated? exporter;

    final subscriptionSignalHandler =
        _initSignalHandler(log, db, exporter, telegramClient);

    final doLoop = _parseBool(globalResults!.command!['run-forever']);
    final dryRun = _parseBool(globalResults!.command!['dry-run']);
    final logLevel = _parseLogLevel();
    final logLevelLibTdJson = _parseLogLevelLibtdjson();
    final fileNameDb = globalResults!.command!['message-database-path'];
    final exportPath = globalResults!.command!['table-dump-path'];
    final chatsNewFullFileName = _buildChatsNewFullFileName();
    final ipfsParams = _buildIpfsParams();
    final ingesterContractParams = _buildIngesterContractParams();
    final fileNameLibTdJson = globalResults!['libtdjson-path'];
    final proxyUri = _parseProxyUri();
    final loginParams = _buildLoginParams();

    while (true) {
      if (dryRun) {
        await Future.delayed(const Duration(seconds: 60));
        continue;
      }

      try {
        log = await LogIsolated.spawn(logLevel);

        telegramClient = await TelegramClientIsolated.spawn(
            log, fileNameLibTdJson, logLevelLibTdJson, proxyUri);

        await telegramClient.login(loginParams);

        db = await DbIsolated.spawn(log, fileNameDb);
        await db.runMigrations();

        final dateTimeFrom = _twoWeeksAgo();
        await telegramClient.saveChatsHistory(
            dateTimeFrom, ingesterContractParams, db);

        final dateTimeFromNewChats = DateTime(2023);
        await telegramClient.saveNewChatsHistory(
            dateTimeFromNewChats, chatsNewFullFileName, db);

        exporter = await ExporterIsolated.spawn(
            log, db, exportPath, ipfsParams, ingesterContractParams);
        await exporter.export();

        if (!doLoop) break;
      } on Object catch (ex) {
        print(ex);
      } finally {
        await Future.delayed(const Duration(seconds: 60));
        _exitIsolates(log, db, exporter, telegramClient);
      }
    }

    subscriptionSignalHandler.cancel();
  }

  StreamSubscription _initSignalHandler(LogIsolated? log, DbIsolated? db,
      ExporterIsolated? exporter, TelegramClientIsolated? telegramClient) {
    return ProcessSignal.sigint.watch().listen((signal) async {
      if ((signal == ProcessSignal.sigint) |
          (signal == ProcessSignal.sigkill)) {
        await _exitIsolates(log, db, exporter, telegramClient);
        exit(0);
      }
    });
  }

  Future<void> _exitIsolates(
      LogIsolated? log,
      DbIsolated? db,
      ExporterIsolated? exporter,
      TelegramClientIsolated? telegramClient) async {
    exporter?.exit();
    await telegramClient?.close();
    await db?.close();
    log?.exit();
  }

  LoginParams _buildLoginParams() {
    return LoginParams(
      _parseInt(globalResults!['api-id'], '--api-id must be an integer'),
      globalResults!['api-hash'],
      globalResults!['phone-number'],
      globalResults!['database-path'],
      readTelegramCode,
      writeQrCodeLink,
      readUserFirstName,
      readUserLastName,
      readUserPassword,
    );
  }

  IngesterContractParams _buildIngesterContractParams() {
    final ingesterContractMaxGas = _parseInt(
      globalResults!.command!['ingester-contract-max-gas'],
      'ingester-contract-max-gas must be an integer',
    );

    return IngesterContractParams(
      globalResults!.command!['ingester-contract-address'],
      globalResults!.command!['ingester-contract-rpc-url'],
      ingesterContractMaxGas,
      globalResults!.command!['config-path'],
      globalResults!.command!['wallet-private-key'],
    );
  }

  IpfsParams _buildIpfsParams() {
    return IpfsParams(
        globalResults!.command!['ipfs-scheme'],
        globalResults!.command!['ipfs-host'],
        globalResults!.command!['ipfs-port'],
        globalResults!.command?['ipfs-username'],
        globalResults!.command?['ipfs-password']);
  }

  DateTime _twoWeeksAgo() {
    final dateTimeTwoWeeksAgo =
        DateTime.now().toUtc().subtract(const Duration(days: 14));
    return DateTime(dateTimeTwoWeeksAgo.year, dateTimeTwoWeeksAgo.month,
        dateTimeTwoWeeksAgo.day);
  }

  Level _parseLogLevel() {
    return _parseLogLevelByName(globalResults!['loglevel']);
  }

  Level _parseLogLevelLibtdjson() {
    return _parseLogLevelByName(globalResults!['libtdjson-loglevel']);
  }

  Level _parseLogLevelByName(String name) {
    return Level.LEVELS.firstWhere(
      (level) => level.name == name.toUpperCase(),
      orElse: () => throw Exception('Invalid log level $name'),
    );
  }

  bool _parseBool(boolToParse) {
    return boolToParse.toLowerCase() == 'true';
  }

  int _parseInt(String intToParse, String message) {
    try {
      return int.parse(intToParse);
    } on FormatException {
      throw Exception(message);
    }
  }

  Uri? _parseProxyUri() {
    Uri? uri;

    if (globalResults?['proxy'] != null) {
      try {
        uri = Uri.parse(globalResults?['proxy']);
        if (['http', 'socks5'].contains(uri.scheme)) {
          return uri;
        } else {
          throw Exception('Invalid proxy scheme ${uri.scheme}.'
              ' Allowed values: http, socks5.');
        }
      } on FormatException catch (ex) {
        throw Exception('Invalid proxy URI: $ex');
      }
    }

    return uri;
  }

  String _buildChatsNewFullFileName() {
    return p.joinAll([
      globalResults!.command!['config-path'],
      globalResults!.command!['new-chats-file-name']
    ]);
  }
}
