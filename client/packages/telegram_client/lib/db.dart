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

  Map<String, dynamic>? selectChat(String username) {
    final parameters = [username];

    logger.fine('selecting chat for $parameters...');
    final resultSet = _database.select(SqlChat.select, parameters);

    if (resultSet.isEmpty) return null;

    final row = resultSet.first;
    final chatInfo = Map<String, dynamic>();
    for (var columnName in resultSet.columnNames) {
      chatInfo[columnName] = row[columnName];
    }
    return chatInfo;
  }

  void blacklistChat(String username, String reason) {
    final now = _now();
    final parameters = [reason, now, username];

    logger.fine('updating chat $parameters...');
    execute(SqlChat.blacklist, parameters);
  }

  void updateChat(String username, Chat chat) {
    final now = _now();
    final chatId = WrapId.unwrapChatId(chat.id);
    final parameters = [chatId, chat.title, now, username];

    logger.fine('updating chat $parameters...');
    execute(SqlChat.update, parameters);
  }

  void updateChatMembersCount(String username, int membersCount) {
    final now = _now();
    final parameters = [membersCount, now, username];

    logger.fine('updating chat $parameters...');
    execute(SqlChat.updateMembersCount, parameters);
  }

  void updateChatMembersOnlineCount(String username, int membersOnlineCount) {
    final now = _now();
    final parameters = [membersOnlineCount, now, username];

    logger.fine('updating chat $parameters...');
    execute(SqlChat.updateMemberOnlineCount, parameters);
  }

  void updateChatBotsCount(String username, int botsCount) {
    final now = _now();
    final parameters = [botsCount, now, username];

    logger.fine('updating chat $parameters...');
    execute(SqlChat.updateBotCount, parameters);
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
      _insertMessages(messages, onlineMembersCount);
      _insertUsers(users);
      _database.execute('COMMIT');
    } on Object {
      _database.execute('ROLLBACK');
      rethrow;
    }
  }

  void _insertMessages(List<Message> messages, int? onlineMembersCount) {
    final stmt = _database.prepare(SqlMessage.insert);
    try {
      for (final message in messages) {
        final parameters = _extractMessageInfo(message, onlineMembersCount);
        logger.fine('inserting message $parameters...');
        stmt.execute(parameters);
      }
    } on Object {
      rethrow;
    } finally {
      stmt.dispose();
    }
  }

  void _insertUsers(List<User> users) {
    final stmt = _database.prepare(SqlUser.insert);
    try {
      for (final user in users) {
        final parameters = _extractUserInfo(user);
        logger.fine('inserting user $parameters...');
        stmt.execute(parameters);
      }
    } on Object {
      rethrow;
    } finally {
      stmt.dispose();
    }
  }

  List<dynamic> _extractMessageInfo(Message message, int? onlineMembersCount) {
    final now = _now();

    int? senderId;
    String? senderType;
    if (message.sender_id != null) {
      senderType = message.sender_id.runtimeType.toString();
      if (message.sender_id.runtimeType == MessageSenderUser) {
        senderId = (message.sender_id as MessageSenderUser).user_id;
      } else if (message.sender_id.runtimeType == MessageSenderChat) {
        senderId = WrapId.unwrapChatId(
            (message.sender_id as MessageSenderChat).chat_id);
      }
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

    return [
      WrapId.unwrapChatId(message.chat_id),
      WrapId.unwrapMessageId(message.id),
      DateTime.fromMillisecondsSinceEpoch(message.date! * 1000)
          .toUtc()
          .toIso8601String(),
      senderId,
      senderType,
      text,
      onlineMembersCount,
      message.interaction_info?.view_count,
      message.interaction_info?.reply_info?.reply_count,
      message.interaction_info?.forward_count,
      replyToId,
      now,
      now,
    ];
  }

  List<dynamic> _extractUserInfo(User user) {
    final now = _now();
    return [
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
  }

  bool userExists(int userId) {
    final parameters = [userId];

    logger.fine('checking if user exists $parameters...');
    final rs = select(SqlUser.select, parameters);
    return rs.isNotEmpty;
  }

  Future<int> exportData(
      String tableName, String fileName, int? fromId, int limit) async {
    final minId = fromId ?? _selectLastUploadedId(tableName) ?? 0;
    final parameters = [minId, limit];

    final stmt = _database.prepare(_sqlSelectDataForExport(tableName));

    var rowCount = 0;
    try {
      final cursor = stmt.selectCursor(parameters);
      final result = await _exportCursor(cursor, fileName);
      rowCount = result[0];
      if (rowCount > 0) _updateLastExportedId(tableName, result[1]);
    } on Object {
      rethrow;
    } finally {
      stmt.dispose();
    }

    logger.fine('exported $rowCount records from $tableName');
    return rowCount;
  }

  Future<int> exportMeta(String tableName, String fileName) async {
    final parameters = [tableName];

    final stmt = _database.prepare(SqlIpfsHash.selectForExport);

    var rowCount = 0;
    try {
      final cursor = stmt.selectCursor(parameters);
      final result = await _exportCursor(cursor, fileName);
      rowCount = result[0];
    } on Object {
      rethrow;
    } finally {
      stmt.dispose();
    }

    logger.fine('exported $rowCount ipfs hashes from $tableName');
    return rowCount;
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
    execute(SqlIpfsUpload.updateMetaFileHash, parameters);
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

  DateTime? selectLastExportDateTime() {
    final updatedAt =
        select(SqlIpfsUpload.selectMaxUpdatedAt, []).firstOrNull?['updated_at'];
    if (updatedAt == null) {
      return null;
    } else {
      return DateTime.parse(updatedAt);
    }
  }

  void _insertIpfsHash(String tableName, String fileHash) {
    final now = _now();
    final parameters = [tableName, fileHash, now, now];

    logger.fine('inserting ipfs hash $parameters...');
    execute(SqlIpfsHash.insert, parameters);
  }

  void _updateLastUploadedId(String tableName) {
    final now = _now();
    final parameters = [now, tableName];

    logger.fine('inserting ipfs hash $parameters...');
    execute(SqlIpfsUpload.updateLastUploadedId, parameters);
  }

  void runMigrations() {
    logger.info('running migrations...');

    _createTables();
    _createIndexes();
    _initIpfsUpload();

    _renameMessageUserIdToSenderId();
    _addMessageSenderType();
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

  void _renameMessageUserIdToSenderId() {
    try {
      _database.execute(SqlMigration.renameMessageUserIdToSenderId);
    } on Object {}
  }

  void _addMessageSenderType() {
    try {
      _database.execute(SqlMigration.addMessageSenderType);
    } on Object {}
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

  Future<List<int>> _exportCursor(
      IteratingCursor cursor, String fileName) async {
    final file = new io.File(fileName);
    file.createSync();

    final sink = file.openWrite(mode: io.FileMode.write);

    var rowCount = 0;
    var rowId = 0;

    try {
      sink.write(jsonEncode(cursor.columnNames) + '\n');

      final flushCount = 100;
      while (cursor.moveNext()) {
        sink.write(jsonEncode(cursor.current.values) + '\n');
        rowCount++;
        rowId = cursor.current['rowid'];
        if (rowCount % flushCount == 0) await sink.flush();
      }
    } on Object {
      rethrow;
    } finally {
      await sink.flush();
      await sink.close();
    }

    return [rowCount, rowId];
  }

  void _updateLastExportedId(String tableName, int exportedId) {
    final now = _now();
    final parameters = [exportedId, now, tableName];

    logger.fine('updating last exported id $parameters...');
    execute(SqlIpfsUpload.updateLastExportedId, parameters);
  }

  String _now() {
    return DateTime.now().toUtc().toIso8601String();
  }

  void execute(String sql, List<Object?> parameters) {
    final stmt = _database.prepare(sql);
    try {
      stmt.execute(parameters);
    } on Object {
      rethrow;
    } finally {
      stmt.dispose();
    }
  }

  ResultSet select(String sql, List<Object?> parameters) {
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
