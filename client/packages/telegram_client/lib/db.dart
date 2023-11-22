import 'dart:async';
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
    if (message.reply_to != null && message.reply_to is MessageReplyToMessage) {
      final messageReplyToMessage = message.reply_to as MessageReplyToMessage;
      if (messageReplyToMessage.message_id != null) {
        replyToId = WrapId.unwrapMessageId(messageReplyToMessage.message_id);
      }
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

  IfpsFileHashesMeta selectMetaFileHahes() {
    logger.fine('selecting meta hashes...');

    var hashes = IfpsFileHashesMeta();

    Row? row;
    row = _database.select(SqlIpfsMeta.selectType, ['chat']).firstOrNull;
    if (row != null) hashes.chat = row['cid'];
    row = _database.select(SqlIpfsMeta.selectType, ['message']).firstOrNull;
    if (row != null) hashes.message = row['cid'];
    row = _database.select(SqlIpfsMeta.selectType, ['user']).firstOrNull;
    if (row != null) hashes.user = row['cid'];

    return hashes;
  }

  void runMigrations() {
    logger.info('running migrations...');

    _createTables();
    _createIndexes();

    _renameMessageUserIdToSenderId();
    _addMessageSenderType();

    _runMigrationAddChatRead();

    _runMigrationChatsNew();

    _addIpfsHashIdMin();
    _addIpfsHashIdMax();

    _runMigrationGroupByMessageDate();
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

  void _runMigrationAddChatRead() {
    _database.execute(SqlChatRead.createTable);
    _database.execute(SqlChatRead.createIndexChatId);
    _database.execute(SqlChatRead.createIndexChatId);
    _database.execute(SqlChatRead.createIndexChatId);
  }

  void _runMigrationChatsNew() {
    _database.execute(SqlChatNew.createTable);
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

  void _addIpfsHashIdMin() {
    try {
      _database.execute(SqlMigration.addIfpsHashIdMin);
    } on Object {}
  }

  void _addIpfsHashIdMax() {
    try {
      _database.execute(SqlMigration.addIfpsHashIdMax);
    } on Object {}
  }

  void _runMigrationGroupByMessageDate() {
    try {
      _database.execute(SqlIpfsMeta.createTable);
      _database.execute(SqlIpfsData.createTable);
      _database.execute(SqlIpfsData.createIdxIpfsData);
      _database.execute(SqlIpfsDataMessage.createTable);
      _database.execute(SqlIpfsDataMessage.createIdxIpfsDataMessage);
      _database.execute(SqlIpfsDataUser.createTable);
      _database.execute(SqlIpfsDataUser.createIdxIpfsDataUser);
      _database.execute(SqlIpfsDataChat.createTable);
      _database.execute(SqlIpfsDataChat.createIdxIpfsDataChat);
      _database.execute(SqlMessage.createIndexSenderId);

      final now = _now();
      for (var type in ['chat', 'message', 'user']) {
        final params = [type, null, null, now, now];
        _database.execute(SqlIpfsMeta.insert, params);
      }
    } on Object {}
  }

  Future<int> _exportCursor(IteratingCursor cursor, String fileName) async {
    final file = new io.File(fileName);
    file.createSync();

    final sink = file.openWrite(mode: io.FileMode.write);

    var rowCount = 0;

    try {
      sink.write(jsonEncode(cursor.columnNames) + '\n');

      final flushCount = 100;
      while (cursor.moveNext()) {
        sink.write(jsonEncode(cursor.current.values) + '\n');
        rowCount++;
        if (rowCount % flushCount == 0) await sink.flush();
      }
    } on Object {
      rethrow;
    } finally {
      await sink.flush();
      await sink.close();
    }

    return rowCount;
  }

  String _now() {
    return DateTime.now().toUtc().toIso8601String();
  }

  int logChatReadStarted(int chatId, DateTime dateTimeStarted) {
    final parameters = [chatId, dateTimeStarted.toUtc().toIso8601String()];
    execute(SqlChatRead.started, parameters);

    var rs = select(SqlChatRead.selectLast, parameters);
    return rs.first['id'];
  }

  void logChatReadFinished(
      int id, int messageCount, DateTime dateTimeFinished) {
    final parameters = [
      messageCount,
      dateTimeFinished.toUtc().toIso8601String(),
      id
    ];
    execute(SqlChatRead.finished, parameters);
  }

  int insertNewChats(String newChatsFullFileName) {
    final file = new io.File(newChatsFullFileName);
    if (!file.existsSync()) return 0;

    final fileLines = file.readAsLinesSync();

    final now = _now();
    var newChatsCount = 0;
    for (var fileLine in fileLines) {
      if (fileLine.isEmpty) continue;
      final parameters = [fileLine, now, now];
      execute(SqlChatNew.insert, parameters);
      newChatsCount++;
    }
    return newChatsCount;
  }

  @override
  bool isNewChat(String username) {
    final parameters = [username];
    final rs = select(SqlChatNew.select, parameters);
    if (rs.isEmpty) return false;
    return true;
  }

  @override
  int? selectNewChatStatus(String username) {
    final parameters = [username];
    final rs = select(SqlChatNew.select, parameters);
    if (rs.isEmpty) return null;
    final row = rs.first;
    return row['status'];
  }

  @override
  int? selectNewChatMessageIdLast(String username) {
    final parameters = [username];
    final rs = select(SqlChatNew.select, parameters);
    if (rs.isEmpty) return null;
    final row = rs.first;
    return row['message_id_last'];
  }

  @override
  bool messageExists(int chatId, int id) {
    final parameters = [chatId, id];

    logger.fine('checking if messages exists $parameters...');
    final rs = select(SqlMessage.select, parameters);
    return rs.isNotEmpty;
  }

  @override
  void updateNewChat(String username, int messageIdLast, int status) {
    final parameters = [messageIdLast, status, username];
    logger.fine('updating new chat $parameters...');
    execute(SqlChatNew.update, parameters);
  }

  @override
  void exportPrepare() {
    _exportPrepareChat();
    _exportPrepareMessageUser();
    _exportPrepareMeta();
  }

  void _exportPrepareChat() {
    logger.info('preparing chats export...');

    final rsSelectRowidChatMaxx = select(SqlChat.selectMaxRowid);
    final rowidChatMax = rsSelectRowidChatMaxx.first['rowid'] ?? 0;

    final rsSelectRowidChatLastPrepared =
        select(SqlIpfsDataChat.selectRowidMessageMax);
    final rowidChatLastPrepared =
        rsSelectRowidChatLastPrepared.first['rowid_chat'] ?? 0;

    final stmtExportPrepareChat =
        _database.prepare(SqlChat.selectPrepareExport);
    final paramExportPrepareMessage = [rowidChatLastPrepared];
    final cursorExportPrepareChat =
        stmtExportPrepareChat.selectCursor(paramExportPrepareMessage);

    var currentChatCount = 0;
    var chatCount = rowidChatMax - rowidChatLastPrepared;

    while (cursorExportPrepareChat.moveNext()) {
      currentChatCount++;

      final rowExportPrepareChat = cursorExportPrepareChat.current;

      if (currentChatCount % exportRecordLimit == 0) {
        logger.info('prepared [$currentChatCount/$chatCount] new chats.');
      }

      final ifpsDataRowChat = _getNextIpfsDataRow('chat');
      if (ifpsDataRowChat == null)
        throw ExportException('Could not get next ipfs_data_rowid for chat');

      _exportPrepareRowChat(rowExportPrepareChat, ifpsDataRowChat);
    }

    execute(SqlIpfsData.updateCidOldChat, [_now()]);

    if (currentChatCount % exportRecordLimit != 0) {
      logger.info('prepared [$currentChatCount/$chatCount] new chats.');
    }

    logger.info('preparing chats export... done.');
  }

  void _exportPrepareMessageUser() {
    logger.info('preparing messages and users export...');

    final rsSelectRowidMessageMax = select(SqlMessage.selectMaxRowid);
    final rowidMessageMax = rsSelectRowidMessageMax.first['rowid'] ?? 0;

    final rsSelectRowidMessageLastPrepared =
        select(SqlIpfsDataMessage.selectRowidMessageMax);
    final rowidMessageLastPrepared =
        rsSelectRowidMessageLastPrepared.first['rowid_message'] ?? 0;

    final stmtExportPrepareMessage =
        _database.prepare(SqlMessage.selectPrepareExport);
    final paramExportPrepareMessage = [rowidMessageLastPrepared];
    final cursorExportPrepareMessage =
        stmtExportPrepareMessage.selectCursor(paramExportPrepareMessage);

    var currentMessageCount = 0;
    var messageCount = rowidMessageMax - rowidMessageLastPrepared;

    while (cursorExportPrepareMessage.moveNext()) {
      currentMessageCount++;

      final rowExportPrepareMessage = cursorExportPrepareMessage.current;
      final date = rowExportPrepareMessage['date'];

      if (currentMessageCount % exportRecordLimit == 0) {
        logger.info(
            'prepared [$currentMessageCount/$messageCount] new messages.');
      }

      final ifpsDataRowMessage = _getNextIpfsDataRow('message', date);
      if (ifpsDataRowMessage == null)
        throw ExportException('Could not get next ipfs_data_rowid for message');

      final ifpsDataRowUser = _getNextIpfsDataRow('user', date);
      if (ifpsDataRowUser == null)
        throw ExportException('Could not get next ipfs_data_rowid for user');

      _exportPrepareRowMessage(
          rowExportPrepareMessage, ifpsDataRowMessage, ifpsDataRowUser);
    }

    if (currentMessageCount % exportRecordLimit != 0) {
      logger
          .info('prepared [$currentMessageCount/$messageCount] new messages.');
    }
    logger.info('preparing messages and users export... done.');
  }

  void _exportPrepareMeta() {
    final now = _now();
    execute(SqlIpfsMeta.updateCidOld, [now]);
    execute(SqlIpfsMeta.clearCidAll, [now]);
  }

  Row? _getNextIpfsDataRow(String type, [String? date = null]) {
    final ipfsDataRow = _selectIpfsDataRow(type, date);
    if (ipfsDataRow != null) return ipfsDataRow;

    _insertIpfsData(type, date);
    return _selectIpfsDataRow(type, date);
  }

  Row? _selectIpfsDataRow(String type, [String? date = null]) {
    if (date == null) {
      final paramsSelectIpfsDataRow = [type, exportRecordLimit];
      final rsSelectIpfsDataRow =
          select(SqlIpfsData.selectPrepare, paramsSelectIpfsDataRow);
      if (rsSelectIpfsDataRow.isNotEmpty) return rsSelectIpfsDataRow.first;
    } else {
      final paramsSelectIpfsDataRow = [type, date, exportRecordLimit];
      final rsSelectIpfsDataRow =
          select(SqlIpfsData.selectPrepareWithDate, paramsSelectIpfsDataRow);
      if (rsSelectIpfsDataRow.isNotEmpty) return rsSelectIpfsDataRow.first;
    }
    return null;
  }

  void _insertIpfsData(String type, [String? date = null]) {
    final now = _now();
    final paramsInsertIpfsDataRow = [type, null, null, date, 0, now, now];
    execute(SqlIpfsData.insert, paramsInsertIpfsDataRow);
  }

  void _exportPrepareRowChat(Row row, Row ifpsDataRowChat) {
    final now = _now();
    try {
      execute('BEGIN');

      execute(SqlIpfsDataChat.insert,
          [ifpsDataRowChat['rowid'], row['rowid_chat'], now]);
      execute(SqlIpfsData.updateRecordCountChat,
          [ifpsDataRowChat['rowid'], now, ifpsDataRowChat['rowid']]);
      if (ifpsDataRowChat['cid'] != null)
        execute(SqlIpfsData.updateCidOld, [now, ifpsDataRowChat['rowid']]);

      execute('COMMIT');
    } on Object {
      execute('ROLLBACK');
      rethrow;
    }
  }

  void _exportPrepareRowMessage(
      Row row, Row ifpsDataRowMessage, Row ifpsDataRowUser) {
    final now = _now();
    try {
      execute('BEGIN');

      execute(SqlIpfsDataMessage.insert,
          [ifpsDataRowMessage['rowid'], row['rowid_message'], now]);
      execute(SqlIpfsData.updateRecordCountMessage,
          [ifpsDataRowMessage['rowid'], now, ifpsDataRowMessage['rowid']]);
      if (ifpsDataRowMessage['cid'] != null)
        execute(SqlIpfsData.updateCidOld, [now, ifpsDataRowMessage['rowid']]);

      execute(SqlIpfsDataUser.insert,
          [ifpsDataRowUser['rowid'], row['rowid_user'], now]);
      execute(SqlIpfsData.updateRecordCountUser,
          [ifpsDataRowUser['rowid'], now, ifpsDataRowUser['rowid']]);
      if (ifpsDataRowUser['cid'] != null)
        execute(SqlIpfsData.updateCidOld, [now, ifpsDataRowUser['rowid']]);

      execute('COMMIT');
    } on Object {
      execute('ROLLBACK');
      rethrow;
    }
  }

  @override
  Future<ExportResult?> exportNextData(String fileName) async {
    final rs = select(SqlIpfsData.selectNextForExport);
    if (rs.isEmpty) return null;

    final row = rs.first;
    final type = row['type'];

    if (type == 'chat') {
      return await _exportDataChat(fileName, row);
    } else if (type == 'message') {
      return await _exportDataMessage(fileName, row);
    } else if (type == 'user') {
      return await _exportDataUser(fileName, row);
    } else {
      logger.warning('invalid export data type');
      return null;
    }
  }

  Future<ExportResult?> _exportDataChat(String fileName, Row row) async {
    final stmt = _database.prepare(SqlChat.selectForExport);
    final parameters = [row['rowid']];
    try {
      final cursor = stmt.selectCursor(parameters);
      final rowCount = await _exportCursor(cursor, fileName);
      logger.info('exported $rowCount chats.');
    } on Object {
      rethrow;
    } finally {
      stmt.dispose();
    }
    return ExportResult(row['type'], row['rowid'], row['cid_old']);
  }

  Future<ExportResult?> _exportDataMessage(String fileName, Row row) async {
    final stmt = _database.prepare(SqlMessage.selectForExport);
    final parameters = [row['rowid']];
    try {
      final cursor = stmt.selectCursor(parameters);
      final rowCount = await _exportCursor(cursor, fileName);
      logger.info('exported $rowCount messages for ${row['date']}.');
    } on Object {
      rethrow;
    } finally {
      stmt.dispose();
    }
    return ExportResult(row['type'], row['rowid'], row['cid_old']);
  }

  Future<ExportResult?> _exportDataUser(String fileName, Row row) async {
    final stmt = _database.prepare(SqlUser.selectForExport);
    final parameters = [row['rowid']];
    try {
      final cursor = stmt.selectCursor(parameters);
      final rowCount = await _exportCursor(cursor, fileName);
      logger.info('exported $rowCount users for ${row['date']}.');
    } on Object {
      rethrow;
    } finally {
      stmt.dispose();
    }
    return ExportResult(row['type'], row['rowid'], row['cid_old']);
  }

  @override
  Future<ExportResult?> exportNextMeta(String fileName) async {
    final rs = select(SqlIpfsMeta.selectNextForExport);
    if (rs.isEmpty) return null;

    final row = rs.first;
    final type = row['type'];

    var sql = SqlIpfsData.selectExportCidDate;
    if (type == 'chat') sql = SqlIpfsData.selectExportCid;

    final stmt = _database.prepare(sql);
    final parameters = [type];
    try {
      final cursor = stmt.selectCursor(parameters);
      final rowCount = await _exportCursor(cursor, fileName);
      logger.info('exported $rowCount meta records for $type.');
    } on Object {
      rethrow;
    } finally {
      stmt.dispose();
    }
    return ExportResult(row['type'], row['rowid'], row['cid_old']);
  }

  @override
  void updateDataCid(int rowid, String cid) {
    final parameters = [cid, _now(), rowid];
    execute(SqlIpfsData.updateCid, parameters);
  }

  @override
  void updateMetaCid(int rowid, String cid) {
    final parameters = [cid, _now(), rowid];
    execute(SqlIpfsMeta.updateCid, parameters);
  }

  @override
  UnpinNextResult? unpinNextData() {
    final rs = select(SqlIpfsData.selectNextForUnpin);
    if (rs.isEmpty) return null;

    final row = rs.first;
    final type = row['type'];

    return UnpinNextResult(type, row['rowid'], row['cid'], row['cid_old']);
  }

  @override
  UnpinNextResult? unpinNextMeta() {
    final rs = select(SqlIpfsMeta.selectNextForUnpin);
    if (rs.isEmpty) return null;

    final row = rs.first;
    final type = row['type'];

    return UnpinNextResult(type, row['rowid'], row['cid'], row['cid_old']);
  }

  void execute(String sql, [List<Object?> parameters = const <Object>[]]) {
    final stmt = _database.prepare(sql);
    try {
      stmt.execute(parameters);
    } on Object {
      rethrow;
    } finally {
      stmt.dispose();
    }
  }

  ResultSet select(String sql, [List<Object?> parameters = const <Object>[]]) {
    final stmt = _database.prepare(sql);
    try {
      return stmt.select(parameters);
    } on Object {
      rethrow;
    } finally {
      stmt.dispose();
    }
  }

  @override
  void clearDataCid(int rowid) {
    final parameters = [_now(), rowid];
    execute(SqlIpfsData.clearCid, parameters);
  }

  @override
  void clearDataCidOld(int rowid) {
    final parameters = [_now(), rowid];
    execute(SqlIpfsData.clearCidOld, parameters);
  }

  @override
  void clearMetaCid(int rowid) {
    final parameters = [_now(), rowid];
    execute(SqlIpfsMeta.clearCid, parameters);
  }

  @override
  void clearMetaCidOld(int rowid) {
    final parameters = [_now(), rowid];
    execute(SqlIpfsMeta.clearCidOld, parameters);
  }

  @override
  void clearCids() {
    final parameters = [_now()];
    execute(SqlIpfsData.clearCids, parameters);
    execute(SqlIpfsMeta.clearCids, parameters);
  }
}
