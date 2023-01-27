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
  // late final db;
  // late final log;
  // late final TelegramClient? telegramClient;

  void run() async {
    hierarchicalLoggingEnabled = true;
    final runForever = parseBool(globalResults!['run-forever']);
    var subSigTerm;

    var logLevel = getLogLevel();
    var logLevelLibTdJson = getLogLevelLibtdjson();

    TelegramClient? telegramClient;
    Log? log;
    Db? db;

    // Signal Handling
      // subSigTerm = await ProcessSignal.sigint.watch().listen((signal) async {
      //   print("signal ${signal}");
      //   if ((signal == ProcessSignal.sigint) | (signal == ProcessSignal.sigkill)) {
      //     print("sigint signal has been given: ${signal}");
      //     await telegramClient?.exit();
      //     await db?.exit();
      //     await log?.exit();
      //     // shutDownIsolates();
      //     subSigTerm.cancel();
      //   } 
      // });
    try {
      log = Log(logLevel: logLevel);
      await log.spawn();

      db = Db(logLevel: logLevel);
      await db.spawn(
      log: log,
      dbPath: globalResults!['message-database-path'],
      );

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
      if (runForever) {
        while(true) {
          await telegramClient.readChatsHistory(
                dateTimeFrom: computeTwoWeeksAgo(),
                chatsNames: getChatsNames(),
                );
        }
      } else {
        await telegramClient.readChatsHistory(
              dateTimeFrom: computeTwoWeeksAgo(),
              chatsNames: getChatsNames(),
              );
      }

      
    } on Exception catch (exception) {
      print("Exception occured ${exception}");
    } finally {
      await telegramClient?.exit();
      await db?.exit();
      await log?.exit();
    }

    

    // shutDownIsolates() async {
    //   await telegramClient?.exit();
    //   await db?.exit();
    //   await log?.exit();
    // }
    
  }

  // Future<void> shutDownIsolates() async {
  //   if (telegramClient != null){
  //     print("telegram client is null");
  //   }
  //     await telegramClient?.exit();
  //     await db?.exit();
  //     await log?.exit();
  //   }

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

  bool parseBool(boolToParse) {
    if (boolToParse.toLowerCase() == 'true') {
      return true;
    } else {
      return false;
    }
  }
}
