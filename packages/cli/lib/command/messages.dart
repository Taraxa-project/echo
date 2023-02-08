import 'dart:io';
import 'dart:convert';
import 'package:args/command_runner.dart';
import 'package:logging/logging.dart';
import 'package:echo_cli/callback/cli.dart';
import 'package:telegram_client/telegram_client.dart';
import 'package:telegram_client/log.dart';
import 'package:telegram_client/db.dart';

class TelegramCommandMessages extends Command {
  final name = 'messages';
  final description = 'Read and save messages from the last two weeks.';

  void run() async {
    hierarchicalLoggingEnabled = true;

    final runForever = parseBool(globalResults!.command!['run-forever']);
    final proxyUri = parseProxyUri();

    final logLevel = getLogLevel();
    final logLevelLibTdJson = getLogLevelLibtdjson();

    while (true) {
      final log = Log(logLevel: logLevel);
      await log.spawn();

      final db = Db(logLevel: logLevel);
      await db.spawn(
        log: log,
        dbPath: globalResults!['message-database-path'],
      );

      TelegramClient? telegramClient;

      var sub = ProcessSignal.sigint.watch().listen((signal) async {
        if ((signal == ProcessSignal.sigint) |
            (signal == ProcessSignal.sigkill)) {
          print("sigint signal has been given: ${signal}");
          await telegramClient?.exit();
          await db.exit();
          await log.exit();
          _exit();
        }
      });

      try {
        await db.open();
        await db.migrate();

        telegramClient = TelegramClient(
          logLevel: logLevel,
          logLevelLibTdJson: logLevelLibTdJson,
          proxyUri: proxyUri,
        );
        await telegramClient.spawn(
          log: log,
          db: db,
          libtdjsonlcPath: globalResults!['libtdjson-path'],
          tdReceiveWaitTimeout: 0.005,
          tdReceiveFrequency: const Duration(milliseconds: 10),
        );
        await telegramClient.login(
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
          await telegramClient.readChatsHistory(
            dateTimeFrom: computeTwoWeeksAgo(),
            chatsNames: getChatsNames(),
          );
          if (!runForever) {
            break;
          }
        }
      } on Exception catch (exception) {
        print('${exception}');
      } finally {
        await telegramClient?.exit();
        await db.exit();
        await log.exit();
        sub.cancel();
      }

      if (runForever) {
        print('Sleeping for 60 seconds.');
        await Future.delayed(const Duration(seconds: 60));
      } else {
        break;
      }
    }
  }

  List<String> getChatsNames() {
    var chatsNamesDecoded;
    print(globalResults!.command!['chats-names']);
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

  Never _exit([String? message = null, code = 1]) {
    if (message != null) print(message);
    exit(code);
  }
}
