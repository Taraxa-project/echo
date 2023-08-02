import 'dart:io' as io;
import 'dart:async';
import 'dart:math';

import 'package:path/path.dart' as p;
import 'package:logging/logging.dart';
import 'package:sqlite3/sqlite3.dart';

import 'package:echo_cli/callback/cli.dart';
import 'package:telegram_client/db_isolated.dart';
import 'package:telegram_client/log_isolated.dart';
import 'package:telegram_client/td_client.dart';
import 'package:telegram_client/telegram_client_interface.dart';
import 'package:telegram_client/telegram_client_isolated.dart';
import 'package:telegram_client/wrap_id.dart';
import 'package:td_json_client/td_api.dart';

Map<String, String> envVars = io.Platform.environment;

final workDir = envVars['work_dir'] ?? '/var/lib/tdlib';
final dbFileName = p.join(workDir, 'check.sqlite');

const chatsFileName = 'chats.csv';
const chatsPerAccount = 500;

const accountsFileName = 'accounts.csv';

const logLevel = Level.INFO;
final logLevelLibTdJson = Level.WARNING;
final fileNameLibTdJson =
    envVars['libtdjson_path'] ?? '/usr/local/lib/libtdjsonlc.so';

const int floodWaitSecondsAdd = 10 * 60;

void main() async {
  hierarchicalLoggingEnabled = true;

  DbIsolated? db;
  LogIsolated? log;

  try {
    log = await LogIsolated.spawn(Level.INFO);
    db = await DbIsolated.spawn(log, dbFileName);

    var check = Check(log, db, workDir);
    await check.runMigrations();
    await check.importChats();
    await check.importAccounts();
    await check.run();
  } on Object {
    rethrow;
  } finally {
    await db?.close();
    log?.exit();
  }
}

class Check {
  final Logger _logger = Logger('Main');
  late final LogIsolated _log;
  late final DbIsolated _db;

  late final String workDir;

  Check(LogIsolated this._log, DbIsolated this._db, String this.workDir) {
    _logger.level = logLevel;
    _logger.onRecord.listen((event) {
      _log.logExternal(event);
    });
  }

  Future<void> runMigrations() async {
    _logger.info('running migrations');

    await _db.execute(SqlChat.createTable);
    await _db.execute(SqlMessage.createTable);
    await _db.execute(SqlMessage.createIndexChatIdId);
    await _db.execute(SqlUser.createTable);
    await _db.execute(SqlUser.createIndexId);
    await _db.execute(SqlAccount.createTable);
    await _db.execute(SqlAccount.createIndexPhoneNumber);

    await _db.execute(SqlChat.resetStatusInProgress);

    try {
      await _db.execute(SqlChat.addColumnOther);
    } on Object {}
  }

  Future<void> importChats() async {
    await logChatCount();

    _logger.info('importing chats');

    final fileNameFullPath = p.join(workDir, chatsFileName);
    final file = new io.File(fileNameFullPath);

    if (!file.existsSync()) {
      _logger.warning('chats file missing: $fileNameFullPath.');
      return;
    }

    final records = file.readAsLinesSync();
    _logger.info('chats file has ${records.length} records.');

    final now = _now();
    for (var record in records) {
      final recordValues = record.split('\t');
      final parameters = recordValues.map((e) {
        try {
          return int.parse(e);
        } on Object {
          return e;
        }
      }).toList();
      parameters.addAll([now, now]);
      await _db.execute(SqlChat.insert, parameters);
    }

    await logChatCount();
  }

  Future<void> logChatCount() async {
    final rs = await _db.select(SqlChat.selectCount);
    final row = rs.first;
    _logger.info('chat table has ${row[0]} records.');
  }

  Future<void> importAccounts() async {
    await logAccountCount();

    _logger.info('importing accounts');

    final fileNameFullPath = p.join(workDir, accountsFileName);
    final file = new io.File(fileNameFullPath);

    if (!file.existsSync()) {
      _logger.warning('accounts file missing: $fileNameFullPath.');
      return;
    }

    final records = file.readAsLinesSync();
    _logger.info('accounts file has ${records.length} records.');

    final now = _now();
    for (var record in records) {
      final recordValues = record.split('\t');
      final parameters = recordValues.map((e) {
        try {
          return int.parse(e);
        } on Object {
          return e;
        }
      }).toList();
      parameters.addAll([now, now]);
      await _db.execute(SqlAccount.insert, parameters);
    }

    await logAccountCount();
  }

  Future<void> logAccountCount() async {
    final rs = await _db.select(SqlAccount.selectCount);
    final row = rs.first;
    _logger.info('account table has ${row[0]} records.');
  }

  Future<void> run() async {
    final accounts = await _db.select(SqlAccount.select);
    for (final account in accounts) {
      await _runAccount(account);
    }
  }

  Future<void> _runAccount(Row account) async {
    int accountId = account['id'];
    _logger.info('[$accountId] start checking...');

    final telegramDatabasePath = _telegramDatabasePath(account);
    _createTelegramDatabasePathDir(telegramDatabasePath);

    final proxyUri = _buildProxyUri(account);
    final loginParams = _buildLoginParams(account, telegramDatabasePath);

    TelegramClientIsolated? telegramClient;

    try {
      while (true) {
        telegramClient = await TelegramClientIsolated.spawn(
            _log, fileNameLibTdJson, logLevelLibTdJson, proxyUri);
        await telegramClient.login(loginParams);

        var rs = await _db.select(SqlChat.selectCountForAccount, [accountId]);
        var row = rs.first;

        int chatCount = row['count'];
        _logger.info('[$accountId] checked $chatCount/$chatsPerAccount');

        if (chatCount >= chatsPerAccount) {
          _logger.info('[$accountId] max chat count $chatsPerAccount reached');
          break;
        }

        rs = await _db.select(SqlChat.selectNext);
        if (rs.length == 0) {
          _logger.info('[$accountId] no more chats to check');
          break;
        }

        row = rs.first;

        final now = _now();

        await _db.execute(
            SqlChat.updateStatusInProgress, [accountId, now, row['username']]);

        try {
          await _checkChat(telegramClient, accountId, row);
        } on TgFloodWaiException catch (ex) {
          _logger.warning(ex);

          await _db.execute(SqlChat.updateStatusNotChecked,
              [accountId, now, row['username']]);

          await telegramClient.close();

          final waitSeconds = ex.waitSeconds + floodWaitSecondsAdd;
          _logger.warning('[$accountId] flood wait for $waitSeconds');
          await Future.delayed(Duration(seconds: waitSeconds));

          continue;
        } on TgBadRequestException catch (ex) {
          _logger.warning(ex);

          await _db.execute(SqlChat.updateStatusOther,
              [ex.toString(), now, accountId, row['username']]);

          await telegramClient.close();

          await _sleepUntilNextChat(accountId);

          continue;
        } on TgTimeOutException catch (ex) {
          _logger.warning(ex);

          await _db.execute(SqlChat.updateStatusOther,
              [ex.toString(), now, accountId, row['username']]);

          await telegramClient.close();

          await _sleepUntilNextChat(accountId);

          continue;
        }

        await _db.execute(
            SqlChat.updateStatusChecked, [now, accountId, row['username']]);

        await telegramClient.close();

        await _sleepUntilNextChat(accountId);
      }

      await Future.delayed(const Duration(seconds: 10));
    } on Object catch (ex) {
      _logger.severe(ex);

      await telegramClient?.close();
    }
  }

  Future<void> _sleepUntilNextChat(int accountId) async {
    int sleepSeconds = _randomBetween(60 * 18, 60 * 22);
    _logger.info('[$accountId]'
        ' sleeping for $sleepSeconds seconds until next chat...');
    await Future.delayed(Duration(seconds: sleepSeconds));
  }

  Future<void> _checkChat(
      TelegramClientIsolated telegramClient, int accountId, Row chat) async {
    int sleepSeconds = 2;

    int chatId = chat['id'];
    String chatUsername = chat['username'];
    _logger.info('[$accountId][$chatId][$chatUsername] checking...');

    _logger.info('[$accountId][$chatId][$chatUsername] SearchPublicChat...');
    var tdResponse = await telegramClient
        .callTdFunction(SearchPublicChat(username: chatUsername));
    if (tdResponse is Error) {
      _logger.severe('[$accountId][$chatId][$chatUsername]'
          ' SearchPublicChat error $tdResponse');
      return;
    }
    _logger.info('[$accountId][$chatId][$chatUsername]'
        ' sleeping for $sleepSeconds seconds'
        ' after searching public chat');
    await Future.delayed(const Duration(seconds: 2));

    StreamController<dynamic>? tdEvents;
    StreamSubscription? tdEventsSubscription;
    try {
      _logger.info('[$accountId][$chatId][$chatUsername]'
          ' subscribing for new messages...');
      tdEvents = telegramClient.subscribe();
      tdEventsSubscription = tdEvents.stream
          .listen(_updateNewMessage(telegramClient, accountId, chat));

      _logger.info('[$accountId][$chatId][$chatUsername] JoinChat...');
      var tdResponse = await telegramClient
          .callTdFunction(JoinChat(chat_id: WrapId.wrapChatId(chatId)));
      if (tdResponse is Error) {
        _logger.severe('[$accountId][$chatId][$chatUsername]'
            ' JoinChat error $tdResponse');
      }

      sleepSeconds = 10;
      _logger.info('[$accountId][$chatId][$chatUsername]'
          ' sleeping for $sleepSeconds seconds'
          ' to wait for new messages...');
      await Future.delayed(Duration(seconds: sleepSeconds));
    } on Object {
      rethrow;
    } finally {
      await tdEventsSubscription?.cancel();
      await tdEvents?.close();
      sleepSeconds = 2;
      _logger.info('[$accountId][$chatId][$chatUsername]'
          ' sleeping for $sleepSeconds seconds'
          ' after canceling subscription for td events...');
      await Future.delayed(Duration(seconds: sleepSeconds));
    }
  }

  dynamic Function(dynamic event) _updateNewMessage(
      TelegramClientIsolated telegramClient, int accountId, Row chat) {
    return (dynamic event) async {
      try {
        // _logger.info(event);

        int chatId = chat['id'];
        String chatUsername = chat['username'];

        if (event is! UpdateNewMessage) return;
        if (event.message == null) return;

        final message = event.message!;
        if (message.chat_id == null) return;
        int chatIdUnwrapped = WrapId.unwrapChatId(message.chat_id);
        if (chatIdUnwrapped != chatId) return;
        if (message.sender_id == null) return;

        final messageSender = message.sender_id!;
        if (messageSender is! MessageSenderUser) return;
        if (messageSender.user_id == null) return;

        final userId = messageSender.user_id!;

        final user =
            await telegramClient.callTdFunction(GetUser(user_id: userId));
        if (user is Error) {
          _logger.severe('[$accountId][$chatId][$chatUsername]'
              ' GetUser error $user');
          return;
        }

        if (user.type is! UserTypeBot) return;

        String? text;
        if (message.content != null) {
          if (message.content is MessageText) {
            var formattedText = (message.content as MessageText).text;
            if (formattedText != null) {
              text = formattedText.text;
            }
          } else if (message.content is MessagePhoto) {
            var formattedText = (message.content as MessagePhoto).caption;
            if (formattedText != null) {
              text = formattedText.text;
            }
          }
        }

        final now = _now();

        var parameters = [
          chatId,
          WrapId.unwrapMessageId(message.id),
          DateTime.fromMillisecondsSinceEpoch(message.date! * 1000)
              .toUtc()
              .toIso8601String(),
          userId,
          messageSender.runtimeType.toString(),
          text,
          now,
          now
        ];
        await _db.execute(SqlMessage.insert, parameters);

        String? username;
        if (user.usernames != null &&
            user.usernames.active_usernames != null &&
            user.usernames.active_usernames.length > 0) {
          username = user.usernames.active_usernames[0];
        }
        parameters = [
          user.id,
          user.first_name,
          user.last_name,
          username,
          user.type is UserTypeBot,
          now,
          now,
        ];
        await _db.execute(SqlUser.insert, parameters);
      } on Object catch (ex) {
        _logger.severe(ex);
      }
    };
  }

  LoginParams _buildLoginParams(Row account, String telegramDatabasePath) {
    return LoginParams(
      account['api_id'],
      account['api_hash'],
      account['phone_number'],
      telegramDatabasePath,
      readTelegramCode,
      writeQrCodeLink,
      readUserFirstName,
      readUserLastName,
      readUserPassword,
    );
  }

  Uri? _buildProxyUri(Row account) {
    Uri? proxyUri;
    if (account['proxy'] != null && account['proxy'] != '') {
      try {
        proxyUri = Uri.parse(account['proxy']);
      } on Object {}
    }
    return proxyUri;
  }

  void _createTelegramDatabasePathDir(String telegramDatabasePath) {
    final dir = io.Directory(telegramDatabasePath);
    if (!dir.existsSync()) {
      dir.createSync();
    }
  }

  String _telegramDatabasePath(Row account) {
    return p.joinAll([workDir, 'account_${account['id']}']);
  }

  String _now() {
    return DateTime.now().toUtc().toIso8601String();
  }

  int _randomBetween(int min, int max) {
    return Random().nextInt(max - min) + min;
  }
}

class SqlChat {
  static const createTable = '''
CREATE TABLE IF NOT EXISTS chat (
  username TEXT UNIQUE ON CONFLICT IGNORE NOT NULL,
  id INTEGER,
  blacklisted INTEGER DEFAULT 0, /* 0 - false; 1 - true; */
  blacklist_reason TEXT,
  status INTEGER NOT NULL DEFAULT 0, /* 0 - not checked; 1 - check in progress; 2 - checked; 3 - other; */
  is_crypto INTEGER DEFAULT 1, /* 0 - false; 1 - true; */
  weekly_message_count INTEGER DEFAULT 0,
  account_id INTEGER,
  created_at TEXT,
  updated_at TEXT);
''';

  static const addColumnOther = '''
ALTER TABLE chat
ADD COLUMN other TEXT;
''';

  static const insert = '''
INSERT INTO chat
  (username, id, blacklisted, blacklist_reason, is_crypto, weekly_message_count, created_at, updated_at)
VALUES
  (?, ?, ?, ?, ?, ?, ?, ?);
''';

  static const selectCount = '''
SELECT
  count(1) count
FROM
  chat;
''';

  static const resetStatusInProgress = '''
UPDATE
  chat
SET
  status = 0,
  account_id = NULL
WHERE
  status = 1 AND
  account_id IS NOT NULL;
''';

  static const selectCountForAccount = '''
SELECT
  count(1) count
FROM
  chat
WHERE
  account_id = ?;
''';

  static const selectNext = '''
SELECT
  *
FROM
  chat
WHERE
  status = 0 AND
  is_crypto = 1
ORDER BY
  weekly_message_count DESC, rowid ASC
LIMIT 1;
''';

  static const updateStatusInProgress = '''
UPDATE
  chat
SET
  status = 1,
  account_id = ?,
  updated_at = ?
WHERE
  account_id IS NULL AND
  username = ?;
''';

  static const updateStatusNotChecked = '''
UPDATE
  chat
SET
  status = 0,
  account_id = ?,
  updated_at = ?
WHERE
  account_id IS NULL AND
  username = ?;
''';

  static const updateStatusChecked = '''
UPDATE
  chat
SET
  status = 2,
  updated_at = ?
WHERE
  account_id = ? AND
  username = ?;
''';

  static const updateStatusOther = '''
UPDATE
  chat
SET
  status = 3,
  other = ?,
  updated_at = ?
WHERE
  account_id = ? AND
  username = ?;
''';
}

class SqlMessage {
  static const createTable = '''
CREATE TABLE IF NOT EXISTS message (
  chat_id INTEGER NOT NULL,
  id INTEGER NOT NULL,
  date TEXT,
  sender_id INTEGER,
  sender_type TEXT,
  text TEXT,
  created_at TEXT,
  updated_at TEXT
);
''';

  static const createIndexChatIdId = '''
CREATE UNIQUE INDEX IF NOT EXISTS idx_message_chat_id_id ON
  message(chat_id, id);
''';

  static const insert = '''
INSERT INTO message
  (chat_id, id, date, sender_id, sender_type, text, created_at, updated_at)
VALUES
  (?, ?, ?, ?, ?, ?, ?, ?)
ON CONFLICT DO NOTHING;
''';
}

class SqlUser {
  static const createTable = '''
CREATE TABLE IF NOT EXISTS user (
  id INTEGER NOT NULL,
  first_name TEXT,
  last_name TEXT,
  username TEXT,
  bot INTEGER,
  created_at TEXT,
  updated_at TEXT
);
''';

  static const createIndexId = '''
CREATE UNIQUE INDEX IF NOT EXISTS idx_user_id ON
  user(id);
''';

  static const insert = '''
INSERT INTO user (
  id, first_name, last_name, username,
  bot, created_at, updated_at
)
VALUES (
  ?, ?, ?, ?,
  ?, ?, ?)
ON CONFLICT DO NOTHING;
''';
}

class SqlAccount {
  static const createTable = '''
CREATE TABLE IF NOT EXISTS account (
  id INTEGER NOT NULL PRIMARY KEY,
  api_id INT NOT NULL,
  api_hash TEXT NOT NULL,
  phone_number TEXT NOT NULL,
  proxy TEXT,
  status INTEGER NOT NULL DEFAULT 1, /* 0 - banned; 1 - active; */
  status_text TEXT,
  created_at TEXT,
  updated_at TEXT
);
''';

  static const createIndexPhoneNumber = '''
CREATE UNIQUE INDEX IF NOT EXISTS idx_account_phone_number ON
  account(phone_number);
''';

  static const selectCount = '''
SELECT
  count(1) count
FROM
  account;
''';

  static const insert = '''
INSERT INTO account
  (api_id, api_hash, phone_number, proxy, created_at, updated_at)
VALUES
  (?, ?, ?, ?, ?, ?)
ON CONFLICT DO NOTHING;
''';

  static const select = '''
SELECT
  *
FROM
  account 
WHERE
  status = 1
ORDER BY
  id ASC;
''';
}
