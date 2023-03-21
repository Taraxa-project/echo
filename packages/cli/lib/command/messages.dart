import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:args/command_runner.dart';
import 'package:logging/logging.dart';
import 'package:cron/cron.dart';
import 'package:echo_cli/callback/cli.dart';

import 'package:telegram_client/isolate.dart';
import 'package:telegram_client/telegram_client.dart';
import 'package:telegram_client/log.dart';
import 'package:telegram_client/db.dart';
import 'package:telegram_client/ipfs_exporter.dart';

class TelegramCommandMessages extends Command {
  final name = 'messages';
  final description = 'Read and save messages from the last two weeks.';

  final Isolater _log = Isolater();
  final Isolater _db = Isolater();
  final Isolater _ipfsExporter = Isolater();
  final TelegramClientIsolater _telegramClient = TelegramClientIsolater();

  late final bool _runForever;
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
          logSendPort: _log.isolateSendPort,
          dbPath: globalResults!['message-database-path'],
        ),
        debugName: 'DbIsolater',
      );

      await _ipfsExporter.spawn_(
        IpfsExporter(
          logLevel: _logLevel,
          logSendPort: _log.isolateSendPort,
          cronFormat: globalResults!.command!['ipfs-cron-schedule'],
          schedule: parseIpfsCronSchedule(),
          dbSendPort: _db.isolateSendPort,
          tableDumpPath: globalResults!.command!['table-dump-path'],
          ipfsScheme: globalResults!.command!['ipfs-scheme'],
          ipfsHost: globalResults!.command!['ipfs-host'],
          ipfsPort: globalResults!.command!['ipfs-port'],
          ipfsUsername: globalResults!.command?['ipfs-username'],
          ipfsPassword: globalResults!.command?['ipfs-password'],
        ),
        debugName: 'IpfsExporterIsolater',
      );

      await _telegramClient.spawn_(
        TelegramClient(
          logLevel: _logLevel,
          logLevelLibTdJson: _logLevelLibTdJson,
          proxyUri: parseProxyUri(),
          logSendPort: _log.isolateSendPort,
          dbSendPort: _db.isolateSendPort,
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

      while (true) {
        await _telegramClient.readChatsHistory(
          dateTimeFrom: computeTwoWeeksAgo(),
          chatsNames: getChatsNames(),
        );

        if (!_runForever) {
          break;
        }

        print('Sleeping for 5 minutes.');
        await Future.delayed(const Duration(minutes: 5));
      }
    } on Exception catch (exception) {
      print(exception);
    } finally {
      await _exitIsolates();
      await _subSignalHandler.cancel();
    }
  }

  void _init() {
    hierarchicalLoggingEnabled = true;

    _runForever = parseBool(globalResults!.command!['run-forever']);
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
    // await _telegramClient.exit();
    // await _ipfsExporter.exit();
    await _db.exit();
    await _log.exit();
  }

  List<String> getChatsNames() {
    var chatsNamesDecoded;

    try {
      chatsNamesDecoded = jsonDecode(globalResults!.command!['chats-names']);
    } on FormatException {
      _invalidInputChats();
    }

    if (chatsNamesDecoded.runtimeType != List || chatsNamesDecoded.isEmpty) {
      _invalidInputChats();
    }

    List<String> chatsNames = [];
    for (var chatNameDecoded in chatsNamesDecoded) {
      if (chatNameDecoded.runtimeType != String) {
        _invalidInputChats();
      }
      chatsNames.add(chatNameDecoded);
    }
    return chatsNames;
  }

  Never _invalidInputChats() {
    _exit('The option "chats-names" must be a valid '
        'JSON encoded list of strings.');
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
