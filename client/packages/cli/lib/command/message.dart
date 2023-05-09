import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:logging/logging.dart';
import 'package:cron/cron.dart';
import 'package:echo_cli/callback/cli.dart';

import 'package:telegram_client/isolate.dart';
import 'package:telegram_client/log.dart';
import 'package:telegram_client/db.dart';
import 'package:telegram_client/telegram_client.dart';

class TelegramCommandChatMessage extends Command {
  final name = 'message';
  final description = 'Read chat message by id.';

  final Isolater _log = Isolater();
  final Isolater _db = Isolater();
  final TelegramClientIsolater _telegramClient = TelegramClientIsolater();

  late final Level _logLevel;
  late final Level _logLevelLibTdJson;
  late final StreamSubscription _subSignalHandler;

  void run() async {
    _init();

    try {
      await _log.spawn_(
        Log(logLevel: _logLevel),
        debugName: 'LogIsolater',
      );

      await _db.spawn_(
        Db(
          logLevel: _logLevel,
          logSendPort: _log.sendPort,
          dbPath: globalResults!['message-database-path'],
        ),
        debugName: 'DbIsolater',
      );

      await _telegramClient.spawn_(
        TelegramClient(
          logLevel: _logLevel,
          logLevelLibTdJson: _logLevelLibTdJson,
          proxyUri: parseProxyUri(),
          logSendPort: _log.sendPort,
          dbSendPort: _db.sendPort!,
          libtdjsonlcPath: globalResults!['libtdjson-path'],
          tdReceiveWaitTimeout: 0.005,
          tdReceiveFrequency: const Duration(milliseconds: 10),
        ),
        debugName: 'TelegramClientIsolater',
      );

      await _telegramClient.login(
        apiId: int.parse(globalResults!['api-id']),
        apiHash: globalResults!['api-hash'],
        phoneNumber: globalResults!['phone-number'],
        databasePath: globalResults!['database-path'],
        readTelegramCode: readTelegramCode,
        writeQrCodeLink: writeQrCodeLink,
        readUserFirstName: readUserFirstName,
        readUserLastName: readUserLastName,
        readUserPassword: readUserPassword,
      );

      var message = await _telegramClient.readChatMessage(
        chatName: globalResults!.command!['chat-name'],
        messageId: parseInt(
          globalResults!.command!['message-id'],
          'message-id is not int',
        ),
      );
      print(message.message);
    } on Exception catch (exception) {
      print(exception);
    } finally {
      await _subSignalHandler.cancel();
      await _exitIsolates();
    }
  }

  void _init() {
    hierarchicalLoggingEnabled = true;

    _logLevel = getLogLevel();
    _logLevelLibTdJson = getLogLevelLibtdjson();

    _initSignalHandler();
  }

  void _initSignalHandler() {
    _subSignalHandler = ProcessSignal.sigint.watch().listen((signal) async {
      if ((signal == ProcessSignal.sigint) |
          (signal == ProcessSignal.sigkill)) {
        await _exitIsolates();
        _exit();
      }
    });
  }

  Future<void> _exitIsolates() async {
    await _telegramClient.exit();
    await _db.exit();
    await _log.exit();
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
