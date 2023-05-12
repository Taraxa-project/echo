import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:logging/logging.dart';
import 'package:cron/cron.dart';
import 'package:echo_cli/callback/cli.dart';

import 'package:telegram_client/ref/lg_isolated.dart';
import 'package:telegram_client/ref/db_isolated.dart';
import 'package:telegram_client/ref/tg_isolated.dart';
import 'package:telegram_client/ref/ingester_contract.dart';

class TelegramCommandMsgs extends Command {
  final name = 'msgs';
  final description = 'Read and save messages from the last two weeks.';

  late final bool _runForever;
  late final Level _logLevel;
  late final Level _logLevelLibTdJson;

  late final int _ingesterContractMaxGas;

  void run() async {
    _init();
    // _timer();

    LgIsolated? lg;
    DbIsolated? db;
    TgIsolated? tg;
    try {
      lg = await LgIsolated.spawn(_logLevel);
      db = await DbIsolated.spawn(lg, globalResults!['message-database-path']);
      tg = await TgIsolated.spawn(
        lg,
        db,
        globalResults!['libtdjson-path'],
        _logLevelLibTdJson,
        parseProxyUri(),
        globalResults!.command!['ingester-contract-address'],
        globalResults!.command!['ingester-contract-rpc-url'],
        _ingesterContractMaxGas,
        globalResults!.command!['config-path'],
        globalResults!.command!['wallet-private-key'],
      );

      await tg.login(
          parseInt(globalResults!['api-id'], '--api-id must be an intege'),
          globalResults!['api-hash'],
          globalResults!['phone-number'],
          globalResults!['database-path'],
          readTelegramCode,
          writeQrCodeLink,
          readUserFirstName,
          readUserLastName,
          readUserPassword);

      await tg.saveChatsHistory();
    } on Object {
      rethrow;
    } finally {
      await tg?.close();
      await db?.close();
      lg?.exit();
    }
  }

  void _init() {
    hierarchicalLoggingEnabled = true;

    _runForever = parseBool(globalResults!.command!['run-forever']);
    _logLevel = getLogLevel();
    _logLevelLibTdJson = getLogLevelLibtdjson();

    _ingesterContractMaxGas = parseInt(
      globalResults!.command!['ingester-contract-max-gas'],
      'ingester-contract-max-gas must be an integer',
    );
  }

  void _timer() {
    final lg = Logger('Timer')
      ..level = Level.ALL
      ..onRecord.listen((event) {
        print(event);
      });
    Timer.periodic(const Duration(seconds: 1), (timer) {
      lg.fine('tick ${timer.tick}');
      if (timer.tick >= 10) {
        lg.fine('cancel');
        timer.cancel();
      }
    });
  }

  DateTime computeTwoWeeksAgo() {
    final dateTimeTwoWeeksAgo =
        DateTime.now().toUtc().subtract(const Duration(days: 14));
    return DateTime(dateTimeTwoWeeksAgo.year, dateTimeTwoWeeksAgo.month,
        dateTimeTwoWeeksAgo.day);
  }

  Level getLogLevel() {
    return getLogLevelByName(globalResults!['loglevel']);
  }

  Level getLogLevelLibtdjson() {
    return getLogLevelByName(globalResults!['libtdjson-loglevel']);
  }

  Level getLogLevelByName(String name) {
    return Level.LEVELS.firstWhere(
      (level) => level.name == name.toUpperCase(),
      orElse: () => Level.WARNING,
    );
  }

  bool parseBool(boolToParse) {
    if (boolToParse.toLowerCase() == 'true') {
      return true;
    } else {
      return false;
    }
  }

  int parseInt(String intToParse, String message) {
    try {
      return int.parse(intToParse);
    } on FormatException {
      _exit(message);
    }
  }

  Uri? parseProxyUri() {
    Uri? uri;

    if (globalResults?['proxy'] != null) {
      try {
        uri = Uri.parse(globalResults?['proxy']);
        if (['http', 'socks5'].contains(uri.scheme)) {
          return uri;
        } else {
          _exit('Invalid proxy scheme ${uri.scheme}.'
              ' Allowed values: http, socks5.');
        }
      } on FormatException catch (ex) {
        _exit('Invalid proxy URI: $ex');
      }
    }

    return uri;
  }

  Schedule parseIpfsCronSchedule() {
    try {
      return Schedule.parse(globalResults!.command!['ipfs-cron-schedule']);
    } on ScheduleParseException catch (ex) {
      _exit('Invalid ipsf-cron-schedule: $ex');
    }
  }

  Never _exit([String? message = null, code = 1]) {
    if (message != null) print(message);
    exit(code);
  }
}
