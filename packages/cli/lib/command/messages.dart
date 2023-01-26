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
    var exception = false;

    var logLevel = getLogLevel();
    var logLevelLibTdJson = getLogLevelLibtdjson();

    final log = Log(logLevel: logLevel);
    await log.spawn();

    final db = Db(logLevel: logLevel);
    await db.spawn(
      log: log,
      dbPath: globalResults!['message-database-path'],
    );

    late final TelegramClient telegramClient;
    try {
      await db.open();
      await db.migrate();

      telegramClient = TelegramClient(
      logLevel: logLevel,
      logLevelLibTdJson: logLevelLibTdJson,
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

      await telegramClient.readChatsHistory(
      dateTimeFrom: computeTwoWeeksAgo(),
      chatsNames: getChatsNames(),
      );

    } on DbException catch (dbException) {
      print(dbException);
      print(dbException.exception);
      await db.exit();
      await log.exit();
    } on TgReadChatsException catch (exception) {
      print(exception);
      await telegramClient.exit();
      await db.exit();
      await log.exit();
    }
  }

  List<String> getChatsNames() {
    var chatsNamesDecoded;

    try {
      chatsNamesDecoded = jsonDecode(globalResults!.command!['chats-names']);
    } on FormatException {
      invalidInputChats();
    }

    if (chatsNamesDecoded.runtimeType != List || chatsNamesDecoded.isEmpty) {
      invalidInputChats();
    }

    List<String> chatsNames = [];
    for (var chatNameDecoded in chatsNamesDecoded) {
      if (chatNameDecoded.runtimeType != String) {
        invalidInputChats();
      }
      chatsNames.add(chatNameDecoded);
    }
    return chatsNames;
  }

  void invalidInputChats() {
    print("The option \"charts-names\" must be a valid "
        "JSON encoded list of strings.");
    exit(1);
  }

  DateTime computeTwoWeeksAgo() {
    return DateTime.now().subtract(const Duration(days: 14));
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
}
