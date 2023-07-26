import 'dart:io' as io;

import 'package:path/path.dart' as p;
import 'package:logging/logging.dart';
import 'package:sqlite3/sqlite3.dart';

import 'package:echo_cli/callback/cli.dart';
import 'package:telegram_client/db_isolated.dart';
import 'package:telegram_client/log_isolated.dart';
import 'package:telegram_client/telegram_client_interface.dart';
import 'package:telegram_client/telegram_client_isolated.dart';

final workDir = String.fromEnvironment('work-dir');
final dbFileName = p.join(workDir, 'check.sqlite');

const chatsFileName = 'chats.csv';
const chatsPerAccount = 500;

const accountsFileName = 'accounts.csv';

const logLevel = Level.INFO;
final logLevelLibTdJson = Level.WARNING;
final fileNameLibTdJson = String.fromEnvironment('libtdjson-path');

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
      await runAccount(account);
    }
  }

  Future<void> runAccount(Row account) async {
    final telegramDatabasePath = _telegramDatabasePath(account);

    final dir = io.Directory(telegramDatabasePath);
    if (!dir.existsSync()) {
      dir.createSync();
    }

    Uri? proxyUri;
    if (account['proxy'] != null && account['proxy'] != '') {
      try {
        proxyUri = Uri.parse(account['proxy']);
      } on Object {}
    }

    final loginParams = _buildLoginParams(account, telegramDatabasePath);

    TelegramClientIsolated? telegramClient;

    try {
      telegramClient = await TelegramClientIsolated.spawn(
          _log, fileNameLibTdJson, logLevelLibTdJson, proxyUri);

      await telegramClient.login(loginParams);
    } on Object catch (ex) {
      _logger.severe(ex);
    } finally {
      await telegramClient?.close();
    }
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

  String _telegramDatabasePath(Row account) {
    return p.joinAll([workDir, 'account_${account['id']}']);
  }

  String _now() {
    return DateTime.now().toUtc().toIso8601String();
  }
}

class SqlChat {
  static const createTable = '''
CREATE TABLE IF NOT EXISTS chat (
  username TEXT UNIQUE ON CONFLICT IGNORE NOT NULL,
  id INTEGER,
  blacklisted INTEGER DEFAULT 0, /* 0 - false; 1 - true; */
  blacklist_reason TEXT,
  status INTEGER NOT NULL DEFAULT 0, /* 0 - not checked; 1 - check in progress; 2 - checked; */
  is_crypto INTEGER DEFAULT 1, /* 0 - false; 1 - true; */
  weekly_message_count INTEGER DEFAULT 0,
  account_id INTEGER,
  created_at TEXT,
  updated_at TEXT);
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
  weekly_message_count DESC, row_id ASC
LIMIT 1;
''';

  static const updateStatusInProgress = '''
UPDATE
  chat
SET
  status = 1,
  account_id = ?
WHERE
  account_id IS NULL AND
  username = ?;
''';

  static const updateStatusChecked = '''
UPDATE
  chat
SET
  status = 2
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
  status INTEGER NOT NULL DEFAULT 0, /* 0 - banned; 1 - active; */
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
  status = 0
ORDER BY
  id ASC;
''';
}
