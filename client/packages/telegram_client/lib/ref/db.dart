import 'package:logging/logging.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:collection/collection.dart';

import 'package:td_json_client/td_api.dart';
import 'package:telegram_client/wrap_id.dart';

import 'db_interface.dart';

class Db implements DbInterface {
  final Logger logger;

  late final Database _database;

  Db(this.logger, String filename) {
    logger.info('opening database $filename...');
    _database = sqlite3.open(filename);

    logger.info('running migrations...');
    _runMigrations();
  }

  void insertChats(List<String> usernames) {
    final now = _now();

    final stmt = _database.prepare(SqlChat.insert);
    try {
      for (var username in usernames) {
        final values = [username, now, now];
        logger.fine('inserting chat $values...');
        stmt.execute(values);
      }
    } on Object {
      rethrow;
    } finally {
      stmt.dispose();
    }
  }

  void blacklistChat(String username, String reason) {
    final now = _now();
    final parameters = [reason, now, username];

    logger.fine('updating chat $parameters...');
    _execute(SqlChat.blacklist, parameters);
  }

  void updateChat(String username, Chat chat) {
    final now = _now();
    final chatId = WrapId.unwrapChatId(chat.id);
    final parameters = [chatId, chat.title, now, username];

    logger.fine('updating chat $parameters...');
    _execute(SqlChat.update, parameters);
  }

  void updateChatMembersCount(String username, int membersCount) {
    final now = _now();
    final parameters = [membersCount, now, username];

    logger.fine('updating chat $parameters...');
    _execute(SqlChat.updateMembersCount, parameters);
  }

  void updateChatMembersOnlineCount(String username, int membersOnlineCount) {
    final now = _now();
    final parameters = [membersOnlineCount, now, username];

    logger.fine('updating chat $parameters...');
    _execute(SqlChat.updateMemberOnlineCount, parameters);
  }

  void updateChatBotsCount(String username, int botsCount) {
    final now = _now();
    final parameters = [botsCount, now, username];

    logger.fine('updating chat $parameters...');
    _execute(SqlChat.updateBotCount, parameters);
  }

  int? selectChatOnlineMembersCount(String username) {
    final parameters = [username];

    logger.fine('selecting member online count for $parameters...');
    final resultSet = _database.select(SqlChat.select, parameters);
    if (resultSet.isNotEmpty)
      return resultSet.first['member_online_count'];
    else
      return null;
  }

  int? selectMaxMessageIdFromDate(int chatId, DateTime dateTimeFrom) {
    final parameters = [chatId, dateTimeFrom.toIso8601String()];

    logger.fine('selecting max message id for $parameters...');
    final resultSet =
        _database.select(SqlMessage.selectMaxIdFromDate, parameters);
    if (resultSet.isNotEmpty)
      return resultSet.first['id'];
    else
      return null;
  }

  void insertMessage(Message message, int? onlineMembersCount) {
    final now = _now();

    int? userId;
    if (message.sender_id != null &&
        message.sender_id.runtimeType == MessageSenderUser) {
      userId = (message.sender_id as MessageSenderUser).user_id;
    }

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

    int? replyToId;
    if (message.reply_to_message_id != null) {
      replyToId = WrapId.unwrapMessageId(message.reply_to_message_id);
    }

    final parameters = [
      WrapId.unwrapChatId(message.chat_id),
      WrapId.unwrapMessageId(message.id),
      DateTime.fromMillisecondsSinceEpoch(message.date! * 1000)
          .toUtc()
          .toIso8601String(),
      userId,
      text,
      onlineMembersCount,
      message.interaction_info?.view_count,
      message.interaction_info?.reply_info?.reply_count,
      message.interaction_info?.forward_count,
      replyToId,
      now,
      now,
    ];

    logger.fine('inserting message $parameters...');
    _execute(SqlMessage.insert, parameters);
  }

  void insertUser(int userId) {
    final now = _now();
    final parameters = [userId, now, now];

    logger.fine('inserting user $parameters...');
    _execute(SqlUser.insert, parameters);
  }

  void updateUser(int userId, User user) {
    final now = _now();
    final parameters = [
      user.first_name,
      user.last_name,
      user.usernames?.active_usernames?.firstOrNull!,
      user.type is UserTypeBot,
      user.is_verified,
      user.is_scam,
      user.is_fake,
      now,
      userId
    ];

    logger.fine('updating user $parameters...');
    _execute(SqlUser.update, parameters);
  }

  void close() {
    logger.info('closing...');
    _database.dispose();
  }

  void _runMigrations() {
    _createTables();
    _createIndexes();
    _initIpfsUpload();
  }

  void _createTables() {
    _database.execute(SqlMigration.createChatTable);
    _database.execute(SqlMigration.createTableMessage);
    _database.execute(SqlMigration.createTableUser);
    _database.execute(SqlMigration.createIpfsUploadTable);
    _database.execute(SqlMigration.createIpfsHashTable);
  }

  void _createIndexes() {
    _database.execute(SqlMigration.createIndexMessageChatIdMessageId);
    _database.execute(SqlMigration.createIndexIpfsHashTableName);
  }

  void _initIpfsUpload() {
    final now = _now();
    final tableNames = ['chat', 'message', 'user'];

    final stmt = _database.prepare(SqlIpfsUpload.insertIpfsUpload);
    try {
      for (var tableName in tableNames)
        stmt.execute([tableName, 0, 0, now, now]);
    } on Object {
      rethrow;
    } finally {
      stmt.dispose();
    }
  }

  String _now() {
    return DateTime.now().toUtc().toIso8601String();
  }

  void _execute(String sql, List<Object?> parameters) {
    final stmt = _database.prepare(sql);
    try {
      stmt.execute(parameters);
    } on Object {
      rethrow;
    } finally {
      stmt.dispose();
    }
  }
}

class SqlMigration {
  static const createChatTable = '''
CREATE TABLE IF NOT EXISTS chat (
  username TEXT UNIQUE ON CONFLICT IGNORE NOT NULL,
  id INTEGER,
  title TEXT,
  member_count INTEGER, 
  member_online_count INTEGER,
  bot_count INTEGER,
  blacklisted INTEGER DEFAULT 0, /* 0 - false; 1 - true; */
  blacklist_reason TEXT,
  created_at TEXT,
  updated_at TEXT
);
''';

  static const createTableMessage = '''
CREATE TABLE IF NOT EXISTS message (
  chat_id INTEGER NOT NULL,
  id INTEGER NOT NULL,
  date TEXT,
  user_id INTEGER,
  text TEXT,
  member_online_count INTEGER,
  views INTEGER,
  replies INTEGER,
  forwards INTEGER,
  reply_to_id INTEGER,
  created_at TEXT,
  updated_at TEXT
);
''';

  static const createTableUser = '''
CREATE TABLE IF NOT EXISTS user (
  id INTEGER NOT NULL PRIMARY KEY,
  user_id INTEGER UNIQUE NOT NULL,
  first_name TEXT,
  last_name TEXT,
  username TEXT,
  bot INTEGER,
  verified INTEGER,
  scam INTEGER,
  fake INTEGER,
  created_at TEXT,
  updated_at TEXT
);
''';

  static const createIpfsUploadTable = '''
CREATE TABLE IF NOT EXISTS ipfs_upload (
  table_name TEXT UNIQUE ON CONFLICT IGNORE NOT NULL,
  last_exported_id INTEGER,
  last_uploaded_id INTEGER,
  meta_file_hash TEXT,
  created_at TEXT,
  updated_at TEXT
);
''';

  static const createIpfsHashTable = '''
CREATE TABLE IF NOT EXISTS ipfs_hash (
  table_name TEXT,
  file_hash TEXT,
  created_at TEXT,
  updated_at TEXT
);
''';

  static const createIndexIpfsHashTableName = '''
CREATE INDEX IF NOT EXISTS idx_ipfs_hash_table_name ON
  ipfs_hash(table_name);
''';

  static const createIndexMessageChatIdMessageId = '''
CREATE UNIQUE INDEX IF NOT EXISTS idx_message_chat_id_message_id ON
  message(chat_id, id);
''';
}

class SqlChat {
  static const insert = '''
INSERT INTO
  chat (username, created_at, updated_at)
VALUES (?, ?, ?);
''';

  static const blacklist = '''
UPDATE
  chat
SET
  blacklisted = 1, blacklist_reason = ?, updated_at = ?
WHERE username = ?;
''';

  static const update = '''
UPDATE 
  chat
SET
  id = ?, title = ?, updated_at = ?
WHERE
  username = ?;
''';

  static const updateMembersCount = '''
UPDATE
  chat
SET
  member_count = ?, updated_at = ?
WHERE
  username = ?;
''';

  static const updateMemberOnlineCount = '''
UPDATE
  chat
SET
  member_online_count = ?, updated_at = ?
WHERE username = ?;
''';

  static const updateBotCount = '''
UPDATE
  chat
SET
  bot_count = ?, updated_at = ?
WHERE username = ?;
''';

  static const select = '''
SELECT
  *
FROM
  chat 
WHERE 
  username = ?;
''';
}

class SqlMessage {
  static const selectMaxIdFromDate = '''
SELECT
  max(id) id
FROM
  message
WHERE
  chat_id = ?
  AND date >= ?;
''';

  static const insert = '''
INSERT INTO message (
  chat_id, id, date, user_id, text, 
  member_online_count, views, replies, forwards, reply_to_id, 
  created_at, updated_at
)
VALUES (
  ?, ?, ?, ?, ?,
  ?, ?, ?, ?, ?,
  ?, ?
) ON CONFLICT DO NOTHING;
''';
}

class SqlUser {
  static const insert = '''
INSERT INTO
  user (user_id, created_at, updated_at)
VALUES (?, ?, ?);
''';

  static const update = '''
UPDATE
  user
SET
  first_name = ?, last_name = ?, username = ?,
  bot = ?, verified = ?, scam = ?, fake = ?, updated_at = ?
WHERE
  user_id = ?;
''';
}

class SqlIpfsUpload {
  static const insertIpfsUpload = '''
INSERT INTO ipfs_upload
  (table_name, last_exported_id, last_uploaded_id, created_at, updated_at)
VALUES
  (?, ?, ?, ?, ?);
''';
}
