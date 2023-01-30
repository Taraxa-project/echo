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

    var logLevel = getLogLevel();
    var logLevelLibTdJson = getLogLevelLibtdjson();

    final log = Log(logLevel: logLevel);
    await log.spawn();

    final db = Db(logLevel: logLevel);
    await db.spawn(
      log: log,
      dbPath: globalResults!['message-database-path'],
    );

    TelegramClient? telegramClient;

    ProcessSignal.sigint.watch().listen((signal) async {
      if ((signal == ProcessSignal.sigint) |
          (signal == ProcessSignal.sigkill)) {
        print("sigint signal has been given: ${signal}");
        await telegramClient?.exit();
        await db.exit();
        await log.exit();
        exit(1);
      }
    });

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
    } on Exception catch (exception) {
      print("Exception occured ${exception}");
    } finally {
      await telegramClient?.exit();
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
}
