import 'dart:io';
import 'dart:convert';

import 'package:args/command_runner.dart';
import 'package:echo_cli/callback/cli.dart';
import 'package:telegram_client/tg.dart';
import 'package:telegram_client/lg.dart';
import 'package:telegram_client/db.dart';

class TelegramCommandMessages extends Command {
  final name = 'messages';
  final description = 'Read and save messages from the last two weeks.';

  final Lg _lg = Lg();

  final Tg _tg = Tg();

  void run() async {
    final Db _db = Db(dbPath: globalResults!['message-database-path']);
    await _lg.spawn();
    await _db.spawn(
      lg: _lg,
    );
    await _tg.spawn(
      lg: _lg,
      db: _db,
      libtdjsonlcPath: globalResults!['libtdjson-path'],
      tdReceiveWaitTimeout: 0.005,
      tdReceiveFrequency: const Duration(milliseconds: 10),
    );

    await _tg.login(
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

    await _tg.readChatsHistory(
      datetimeFrom: computeTwoWeeksAgo(),
      chatsNames: getChatsNames(),
    );

    await _tg.exit();
    await _db.close();
    await _lg.exit();
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

  // Level getLogLevel() {
  //   return getLogLevelByName(globalResults!['loglevel']);
  // }

  // Level getLogLevelLibtdjson() {
  //   return getLogLevelByName(globalResults!['libtdjson-loglevel']);
  // }

  // Level getLogLevelByName(String name) {
  //   return Level.LEVELS.firstWhere(
  //     (level) => level.name == name.toUpperCase(),
  //     orElse: () => Level.WARNING,
  //   );
  // }
}
