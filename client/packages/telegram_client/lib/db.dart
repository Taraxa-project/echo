import 'dart:io' as io;
import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:collection/collection.dart';

import 'package:td_json_client/td_api.dart';

import 'db_interface.dart';
import 'db_sql.dart';
import 'wrap_id.dart';

class Db implements DbInterface {
  final Logger logger;

  late final Database _database;

  Db(this.logger, String filename) {
    logger.info('opening database $filename...');
    _database = sqlite3.open(filename);

    logger.info('running migrations...');
    _runMigrations();
  }

  void close() {
    logger.info('closing...');
    _database.dispose();
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
    final parameters = [chatId, dateTimeFrom.toUtc().toIso8601String()];

    logger.fine('selecting max message id for $parameters...');
    final resultSet =
        _database.select(SqlMessage.selectMaxIdFromDate, parameters);
    if (resultSet.isNotEmpty) return resultSet.first['id'];
    return null;
  }

  void insertMessagesUsers(
      List<Message> messages, List<User> users, int? onlineMembersCount) {
    try {
      _database.execute('BEGIN');
      for (final message in messages)
        insertMessage(message, onlineMembersCount);
      for (final user in users) insertUser(user);
      _database.execute('COMMIT');
    } on Object {
      _database.execute('ROLLBACK');
      rethrow;
    }
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

  bool userExists(int userId) {
    final parameters = [userId];

    logger.fine('checking if user exists $parameters...');
    final rs = _select(SqlUser.select, parameters);
    return rs.isNotEmpty;
  }

  void insertUser(User user) {
    final now = _now();
    final parameters = [
      user.id,
      user.first_name,
      user.last_name,
      user.usernames?.active_usernames?.firstOrNull!,
      user.type is UserTypeBot,
      user.is_verified,
      user.is_scam,
      user.is_fake,
      now,
      now,
    ];

    logger.fine('inserting user $parameters...');
    _execute(SqlUser.insert, parameters);
  }

  Future<int> exportData(String tableName, String fileName, int? fromId) async {
    final minId = fromId ?? _selectLastUploadedId(tableName) ?? 0;
    final parameters = [minId];

    final rs = _select(_sqlSelectDataForExport(tableName), parameters);
    if (rs.isNotEmpty) {
      await _exportResultSet(rs, fileName);
      _updateLastExportedId(tableName, rs.last['rowid']);
    }

    logger.fine('exported ${rs.length} records from $tableName');
    return rs.length;
  }

  Future<int> exportMeta(String tableName, String fileName) async {
    final parameters = [tableName];

    final rs = _select(SqlIpfsHash.selectForExport, parameters);
    if (rs.isNotEmpty) await _exportResultSet(rs, fileName);

    logger.fine('exported ${rs.length} ipfs hashes for $tableName');
    return rs.length;
  }

  void insertIpfsHash(String tableName, String fileHash) {
    try {
      _database.execute('BEGIN');
      _insertIpfsHash(tableName, fileHash);
      _updateLastUploadedId(tableName);
      _database.execute('COMMIT');
    } on Object {
      _database.execute('ROLLBACK');
      rethrow;
    }
  }

  void updateMetaFileHash(String tableName, String fileHash) {
    final now = _now();
    final parameters = [fileHash, now, tableName];

    logger.fine('updating ipfs meta $parameters...');
    _execute(SqlIpfsUpload.updateMetaFileHash, parameters);
  }

  IfpsFileHashesMeta selectMetaFileHahes() {
    logger.fine('selecting meta hashes...');

    var hashes = IfpsFileHashesMeta();

    Row? row;
    row = _database.select(SqlIpfsUpload.select, ['chat']).firstOrNull;
    if (row != null) hashes.chat = row['meta_file_hash'];
    row = _database.select(SqlIpfsUpload.select, ['message']).firstOrNull;
    if (row != null) hashes.message = row['meta_file_hash'];
    row = _database.select(SqlIpfsUpload.select, ['user']).firstOrNull;
    if (row != null) hashes.user = row['meta_file_hash'];

    return hashes;
  }

  void _insertIpfsHash(String tableName, String fileHash) {
    final now = _now();
    final parameters = [tableName, fileHash, now, now];

    logger.fine('inserting ipfs hash $parameters...');
    _execute(SqlIpfsHash.insert, parameters);
  }

  void _updateLastUploadedId(String tableName) {
    final now = _now();
    final parameters = [now, tableName];

    logger.fine('inserting ipfs hash $parameters...');
    _execute(SqlIpfsUpload.updateLastUploadedId, parameters);
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

    final stmt = _database.prepare(SqlIpfsUpload.insert);
    try {
      for (var tableName in tableNames)
        stmt.execute([tableName, 0, 0, now, now]);
    } on Object {
      rethrow;
    } finally {
      stmt.dispose();
    }
  }

  int? _selectLastUploadedId(String tableName) {
    final parameters = [tableName];

    logger.fine('selecting last uploaded id for $parameters...');
    final resultSet = _database.select(SqlIpfsUpload.select, parameters);
    if (resultSet.isNotEmpty) return resultSet.first['last_uploaded_id'];
    return null;
  }

  String _sqlSelectDataForExport(String tableName) {
    if (tableName == 'chat') {
      return SqlChat.selectForExport;
    } else if (tableName == 'message') {
      return SqlMessage.selectForExport;
    } else {
      return SqlUser.selectForExport;
    }
  }

  Future<void> _exportResultSet(ResultSet rs, String fileName) async {
    final file = new io.File(fileName);
    file.createSync();

    final sink = file.openWrite(mode: io.FileMode.write);
    sink.write(jsonEncode(rs.columnNames) + '\n');

    for (final row in rs) sink.write(jsonEncode(row.values) + '\n');

    await sink.flush();
    await sink.close();
  }

  void _updateLastExportedId(String tableName, int exportedId) {
    final now = _now();
    final parameters = [exportedId, now, tableName];

    logger.fine('updating last exported id $parameters...');
    _execute(SqlIpfsUpload.updateLastExportedId, parameters);
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

  ResultSet _select(String sql, List<Object?> parameters) {
    final stmt = _database.prepare(sql);
    try {
      return stmt.select(parameters);
    } on Object {
      rethrow;
    } finally {
      stmt.dispose();
    }
  }
}
