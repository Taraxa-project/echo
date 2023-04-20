import 'dart:isolate';
import 'dart:io' as io;
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:http/retry.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:logging/logging.dart';
import 'package:td_json_client/td_api.dart';
import 'package:telegram_client/wrap_id.dart';

import 'isolate.dart';

class Db extends Isolated {
  SendPort? logSendPort;

  final String dbPath;
  Database? db;

  static const maxTries = 3;

  Db({
    Level? super.logLevel,
    this.logSendPort,
    required this.dbPath,
  }) {
    logger.onRecord.listen((logRecord) {
      logSendPort?.send(logRecord);
    });
  }

  void init(SendPort parentSendPort) {
    super.init(parentSendPort);
    _open();
    _migrate();
  }

  Future<void> initDispatch() async {
    receivePortBroadcast.listen((message) async {
      if (message is IsolateMsgRequestExit) {
        logger.fine('exiting...');
        exit(message.replySendPort);
      } else if (message is DbMsgRequestOpen) {
        message.replySendPort?.send(_retryDbOperation(
          () => _open(),
          DbMsgResponseOpen(),
          'open db',
        ));
      } else if (message is DbMsgRequestMigrate) {
        message.replySendPort?.send(_retryDbOperation(
          () => _migrate(),
          DbMsgResponseMigrate(),
          'migrate',
        ));
      } else if (message is DbMsgRequestAddChats) {
        message.replySendPort?.send(_retryDbOperation(
          () => _addChats(message.usernames),
          DbMsgResponseAddChats(),
          'add chats',
        ));
      } else if (message is DbMsgRequestBlacklistChat) {
        message.replySendPort?.send(_retryDbOperation(
            () => _blacklistChat(
                username: message.username, reason: message.reason),
            DbMsgResponseBlacklistChat(),
            'blacklist chat'));
      } else if (message is DbMsgRequestUpdateChat) {
        message.replySendPort?.send(_retryDbOperation(
            () => _updateChat(
                  username: message.username,
                  chat: message.chat,
                ),
            DbMsgResponseUpdateChat(),
            "update chat"));
      } else if (message is DbMsgRequestUpdateChatMembersCount) {
        message.replySendPort?.send(_retryDbOperation(
            () => _updateChatMembersCount(
                  username: message.username,
                  memberCount: message.membersCount,
                ),
            DbMsgResponseUpdateChatMembersCount(),
            "update chat members count"));
      } else if (message is DbMsgRequestUpdateChatMembersBotsCount) {
        message.replySendPort?.send(_retryDbOperation(
            () => _updateChatMembersBotsCount(
                  username: message.username,
                  memberCount: message.membersCount,
                ),
            DbMsgResponseUpdateChatMembersBotsCount(),
            "update chat members bots count"));
      } else if (message is DbMsgRequestUpdateChatMembersOnlineCount) {
        message.replySendPort?.send(_retryDbOperation(
            () => _updateChatMembersOnlineCount(
                  username: message.username,
                  memberCount: message.membersCount,
                ),
            DbMsgResponseUpdateChatMembersOnlineCount(),
            "update chat members online count"));
      } else if (message is DbMsgRequestSelectMaxMessageId) {
        message.replySendPort?.send(_retryDbOperation(
          () => _selectMaxMessageId(
            chatId: message.chatId,
            dateTimeFrom: message.dateTimeFrom,
          ),
          DbMsgResponseSelectMaxMessageId(id: null),
          "select max message id",
        ));
      } else if (message is DbMsgRequestAddMessage) {
        message.replySendPort?.send(_retryDbOperation(
          () => _addMessage(
              message: message.message,
              online_member_count: message.onlineMemberCount),
          DbMsgResponseAddMessage(added: false),
          "add message",
        ));
      } else if (message is DbMsgRequestAddUser) {
        message.replySendPort?.send(_retryDbOperation(
          () => _addUser(userId: message.userId),
          DbMsgResponseAddUser(),
          "add user",
        ));
      } else if (message is DbMsgRequestUpdateUser) {
        message.replySendPort?.send(_retryDbOperation(
          () => _updateUser(userId: message.userId, user: message.user),
          DbMsgResponseUpdateUser(),
          "update user",
        ));
      } else if (message is DbMsgRequestSelectChatOnlineMemberCount) {
        message.replySendPort?.send(_retryDbOperation(
          () => _selectChatOnlineMemberCount(
            chatName: message.chatName,
          ),
          DbMsgResponseSelectChatOnlineMemberCount(),
          "select chat online member count",
        ));
      } else if (message is DbMsgRequestDumpData) {
        message.replySendPort?.send(await _retryDbOperationAsync(
          () async {
            return await _dumpData(
              tableName: message.tableName,
              fileName: message.fileName,
              fromId: message.fromId,
            );
          },
          DbMsgResponseDumpData(count: 0),
          'dump data locally',
        ));
      } else if (message is DbMsgRequestUploadDataSucces) {
        message.replySendPort?.send(_retryDbOperation(
          () => _uploadDataSuccess(message.tableName, message.file_hash),
          DbMsgResponseUploadDataSucces(),
          "upload succes",
        ));
      } else if (message is DbMsgRequestDumpMeta) {
        message.replySendPort?.send(await _retryDbOperationAsync(
          () async {
            return await _dumpMeta(
              tableName: message.tableName,
              fileName: message.fileName,
            );
          },
          DbMsgResponseDumpMeta(count: 0),
          'dump meta locally',
        ));
      } else if (message is DbMsgRequestUploadMetaSucces) {
        message.replySendPort?.send(_retryDbOperation(
          () => _uploadMetaSuccess(message.tableName, message.file_hash),
          DbMsgResponseUploadMetaSucces(),
          "upload meta succes",
        ));
      } else if (message is DbMsgRequestGetUploadHashes) {
        message.replySendPort?.send(_retryDbOperation(
          () => _getUploadHashes(),
          DbMsgResponseGetUploadHashes(),
          'get upload meta hashes',
        ));
      }
    });
  }

  DbMsgResponse _retryDbOperation(
    DbMsgResponse Function() dbOperation,
    DbMsgResponse DbMsgResponse,
    String operationName,
  ) {
    var exception;

    var retryCount = 0;
    while (retryCount < maxTries) {
      retryCount += 1;

      exception = null;
      try {
        return dbOperation();
      } on SqliteException catch (ex) {
        exception = ex;
        if (exception.resultCode == 19) {
          return DbMsgResponseConstraintError(exception: exception);
        }
        if (_dbErrorHandler(ex, operationName) == false) {
          break;
        }
      }
    }

    DbMsgResponse.operationName = operationName;
    DbMsgResponse.exception = exception;

    return DbMsgResponse;
  }

  Future<DbMsgResponse> _retryDbOperationAsync(
    Future<DbMsgResponse> Function() dbOperation,
    DbMsgResponse DbMsgResponse,
    String operationName,
  ) async {
    var exception;

    var retryCount = 0;
    while (retryCount < maxTries) {
      retryCount += 1;

      exception = null;
      try {
        return await dbOperation();
      } on SqliteException catch (ex) {
        exception = ex;
        if (exception.resultCode == 19) {
          return DbMsgResponseConstraintError(exception: exception);
        }
        if (_dbErrorHandler(ex, operationName) == false) {
          break;
        }
      }
    }

    DbMsgResponse.operationName = operationName;
    DbMsgResponse.exception = exception;

    return DbMsgResponse;
  }

  Future<void> exit(SendPort? replySendPort) async {
    logger.fine('closing DB...');
    db?.dispose();
    logger.fine('closed.');

    replySendPort?.send(IsolateMsgResponseExit());

    await Future.delayed(const Duration(milliseconds: 10));
    logger.fine('closing DB port');
    receivePort.close();
    Isolate.exit();
  }

  DbMsgResponseOpen _open() {
    logger.fine('opening...');
    db = sqlite3.open(this.dbPath);
    logger.fine('opened.');
    return DbMsgResponseOpen();
  }

  DbMsgResponseMigrate _migrate() {
    logger.fine('running migrations...');

    for (final sql in _sqlInit()) {
      db?.execute(sql);
    }
    for (var tableName in ['chat', 'message', 'user']) {
      db?.execute(_sqlInitIpfsUploadTable, [
        tableName,
        0,
        0,
        DateTime.now().toUtc().toIso8601String(),
        DateTime.now().toUtc().toIso8601String(),
      ]);
    }

    logger.fine('running migrations... done.');

    return DbMsgResponseMigrate();
  }

  DbMsgResponseAddChats _addChats(List<String> usernames) {
    for (var username in usernames) {
      logger.fine('adding chat $username...');
      final stmt = db?.prepare(_sqlInsertChat);
      stmt?.execute([
        username,
        DateTime.now().toUtc().toIso8601String(),
        DateTime.now().toUtc().toIso8601String(),
      ]);
      logger.fine('added chat $username.');
      stmt?.dispose();
    }
    return DbMsgResponseAddChats();
  }

  DbMsgResponseUpdateChat _updateChat({
    required String username,
    required Chat chat,
  }) {
    final stmt = db?.prepare(_sqlUpdateChat);

    var id = WrapId.unwrapChatId(chat.id);
    logger.fine('updating chat $username, id $id...');

    stmt?.execute([
      id,
      chat.title,
      DateTime.now().toUtc().toIso8601String(),
      username,
    ]);
    logger.fine('updated chat $username, id $id.');

    stmt?.dispose();

    return DbMsgResponseUpdateChat();
  }

  DbMsgResponseUpdateChatMembersCount _updateChatMembersCount({
    required String username,
    required int memberCount,
  }) {
    final stmt = db?.prepare(_sqlUpdateChatMemberCount);

    logger.fine('updating chat $username, members count $memberCount...');
    stmt?.execute([
      memberCount,
      DateTime.now().toUtc().toIso8601String(),
      username,
    ]);
    logger.fine('updated chat $username, members count $memberCount.');

    stmt?.dispose();
    return DbMsgResponseUpdateChatMembersCount();
  }

  DbMsgResponseUpdateChatMembersBotsCount _updateChatMembersBotsCount({
    required String username,
    required int memberCount,
  }) {
    final stmt = db?.prepare(_sqlUpdateChatBotCount);

    logger.fine('updating chat $username, bots count $memberCount...');
    stmt?.execute([
      memberCount,
      DateTime.now().toUtc().toIso8601String(),
      username,
    ]);
    logger.fine('updated chat $username, bots count $memberCount.');

    stmt?.dispose();

    return DbMsgResponseUpdateChatMembersBotsCount();
  }

  DbMsgResponseUpdateChatMembersOnlineCount _updateChatMembersOnlineCount({
    required String username,
    required int memberCount,
  }) {
    final stmt = db?.prepare(_sqlUpdateChatMemberOnlineCount);

    logger.fine('updating chat $username, bots count $memberCount...');
    stmt?.execute([
      memberCount,
      DateTime.now().toUtc().toIso8601String(),
      username,
    ]);
    logger.fine('updated chat $username, bots count $memberCount.');

    stmt?.dispose();

    return DbMsgResponseUpdateChatMembersOnlineCount();
  }

  DbMsgResponseBlacklistChat _blacklistChat({
    required String username,
    required String reason,
  }) {
    final stmt = db?.prepare(_sqlBlacklistChat);

    logger.fine('blacklisting chat $username, reason $reason...');
    stmt?.execute([
      reason,
      DateTime.now().toUtc().toIso8601String(),
      username,
    ]);
    logger.fine('blacklisted chat $username.');

    stmt?.dispose();

    return DbMsgResponseBlacklistChat();
  }

  DbMsgResponseSelectMaxMessageId _selectMaxMessageId({
    required int chatId,
    required DateTime dateTimeFrom,
  }) {
    logger.fine('reading last message id for $chatId...');

    final ResultSet? resultSet = db?.select(
      _sqlSelectMaxMessageId,
      [
        chatId,
        dateTimeFrom.toIso8601String(),
      ],
    );

    int? id;
    if (resultSet != null && resultSet.isNotEmpty) {
      id = resultSet.first['id'];
      logger.fine('found last message id $id for chat $chatId.');
    } else {
      logger.fine('did not find last message id for chat $chatId.');
    }

    return DbMsgResponseSelectMaxMessageId(id: id);
  }

  DbMsgResponseAddMessage _addMessage({
    required Message message,
    int? online_member_count,
  }) {
    if (message.chat_id == null || message.id == null || message.date == null) {
      return DbMsgResponseAddMessage(
        added: false,
      );
    }
    final stmt = db?.prepare(_sqlInsertMessage);

    var userId = null;
    if (message.sender_id != null &&
        message.sender_id.runtimeType == MessageSenderUser) {
      userId = (message.sender_id as MessageSenderUser).user_id;
    }

    var text = null;
    if (message.content != null && message.content.runtimeType == MessageText) {
      var formattedText = (message.content as MessageText).text;
      if (formattedText != null) {
        text = formattedText.text;
      }
    }

    var reply_to_id;
    if (message.reply_to_message_id != null) {
      reply_to_id = WrapId.unwrapMessageId(message.reply_to_message_id);
    }

    stmt?.execute([
      WrapId.unwrapChatId(message.chat_id),
      WrapId.unwrapMessageId(message.id),
      DateTime.fromMillisecondsSinceEpoch(message.date! * 1000)
          .toUtc()
          .toIso8601String(),
      userId,
      text,
      online_member_count,
      message.interaction_info?.view_count,
      message.interaction_info?.reply_info?.reply_count,
      message.interaction_info?.forward_count,
      reply_to_id,
      DateTime.now().toUtc().toIso8601String(),
      DateTime.now().toUtc().toIso8601String(),
    ]);
    stmt?.dispose();

    return DbMsgResponseAddMessage(added: true);
  }

  DbMsgResponseAddUser _addUser({required int userId}) {
    logger.fine('Adding new user  $userId...');
    final stmt = db?.prepare(_sqlInsertUser);
    stmt?.execute([
      userId,
      DateTime.now().toUtc().toIso8601String(),
      DateTime.now().toUtc().toIso8601String(),
    ]);
    stmt?.dispose();
    logger.fine('User $userId added');
    return DbMsgResponseAddUser();
  }

  DbMsgResponseUpdateUser _updateUser(
      {required int userId, required User user}) {
    logger.fine('Adding new user  $userId...');
    final stmt = db?.prepare(_sqlUpdateUser);
    stmt?.execute([
      user.first_name,
      user.last_name,
      user.usernames?.active_usernames?.firstOrNull!,
      user.type is UserTypeBot,
      user.is_verified,
      user.is_scam,
      user.is_fake,
      userId
    ]);
    stmt?.dispose();
    logger.fine('User $userId added');
    return DbMsgResponseUpdateUser();
  }

  DbMsgResponseSelectChatOnlineMemberCount _selectChatOnlineMemberCount({
    required String chatName,
  }) {
    logger.fine('reading member online count for $chatName...');

    final ResultSet? resultSet = db?.select(
      _sqlSelectChat,
      [chatName],
    );

    int? result;
    if (resultSet != null && resultSet.isNotEmpty) {
      result = resultSet.first['member_online_count'];
      logger.fine('found member online count $result for chat $chatName.');
    } else {
      logger.fine('did not find member online count for chat $chatName.');
    }

    return DbMsgResponseSelectChatOnlineMemberCount(
      onlineMemberCount: result,
    );
  }

  Future<DbMsgResponseDumpData> _dumpData({
    required String tableName,
    required String fileName,
    int? fromId,
  }) async {
    if (fromId == null) {
      fromId = _lastUploadedId(tableName);
    }
    logger.info('exporting $tableName from id $fromId...');

    final stmtSelect = db?.prepare(_sqlSelectDataForDump(tableName));
    final rs = stmtSelect?.select([fromId]);

    var count = 0;
    if (rs != null && rs.isNotEmpty) {
      await _dumpResultSet(rs, fileName);
      _updateLastExportedId(tableName, rs.last['rowid']);
      count = rs.length;
    }
    stmtSelect?.dispose();

    logger.info('exporting $tableName from id $fromId... done:'
        ' $count records.');

    return DbMsgResponseDumpData(count: count);
  }

  Future<DbMsgResponseDumpMeta> _dumpMeta({
    required String tableName,
    required String fileName,
  }) async {
    logger.info('exporting $tableName ipfs file hashes...');

    final stmtSelect = db?.prepare(_sqlSelectMetaForDump);
    final rs = stmtSelect?.select([tableName]);

    var count = 0;
    if (rs != null && rs.isNotEmpty) {
      await _dumpResultSet(rs, fileName);
      count = rs.length;
    }
    stmtSelect?.dispose();

    logger.info('exporting $tableName ipfs file hashes... done:'
        ' $count records.');

    return DbMsgResponseDumpMeta(count: count);
  }

  void _updateLastExportedId(String tableName, id) {
    final stmtUpdate = db?.prepare(_sqlUpdateIpfsUploadLastExportedId);
    stmtUpdate?.execute([id, tableName]);
    stmtUpdate?.dispose();
  }

  DbMsgResponseUploadDataSucces _uploadDataSuccess(
    String tableName,
    String file_hash,
  ) {
    final stmtUpdateLastUploadId =
        db?.prepare(_sqlUpdateIpfsUploadLastUploadedId);
    stmtUpdateLastUploadId?.execute([tableName]);
    stmtUpdateLastUploadId?.dispose();

    final stmtInsertIpfsHash = db?.prepare(_sqlInsertIpfsHash);
    stmtInsertIpfsHash?.execute([
      tableName,
      file_hash,
      DateTime.now().toUtc().toIso8601String(),
      DateTime.now().toUtc().toIso8601String(),
    ]);
    stmtInsertIpfsHash?.dispose();

    return DbMsgResponseUploadDataSucces();
  }

  DbMsgResponseUploadMetaSucces _uploadMetaSuccess(
    String tableName,
    String file_hash,
  ) {
    final stmtUpdatMetaIpfsHash = db?.prepare(_sqlUpdateIpfsUploadMetaFileHash);
    stmtUpdatMetaIpfsHash?.execute([
      tableName,
      file_hash,
    ]);
    stmtUpdatMetaIpfsHash?.dispose();

    return DbMsgResponseUploadMetaSucces();
  }

  int _lastUploadedId(String tableName) {
    int id = 0;

    Row? row;
    row = db?.select(_sqlSelectIpfsUpload, [tableName]).firstOrNull;
    if (row != null) {
      id = row['last_uploaded_id'] ?? 0;
    }

    return id;
  }

  Future<void> _dumpResultSet(
    ResultSet rs,
    String fileName, [
    bool addColumnNames = true,
  ]) async {
    final file = new io.File(fileName);
    file.createSync();

    final sink = file.openWrite(mode: io.FileMode.write);

    if (addColumnNames) {
      sink.write(jsonEncode(rs.columnNames));
      sink.write('\n');
    }

    for (var row in rs) {
      sink.write(jsonEncode(row.values));
      sink.write('\n');
    }

    await sink.flush();
    await sink.close();
  }

  DbMsgResponseGetUploadHashes _getUploadHashes() {
    logger.fine('reading uploaded meta hashes...');

    var response = DbMsgResponseGetUploadHashes();

    Row? row;

    row = db?.select(_sqlSelectIpfsUpload, ['chat']).firstOrNull;
    if (row != null) {
      response.chat_hash = row['meta_file_hash'];
    }

    row = db?.select(_sqlSelectIpfsUpload, ['message']).firstOrNull;
    if (row != null) {
      response.message_hash = row['meta_file_hash'];
    }

    row = db?.select(_sqlSelectIpfsUpload, ['user']).firstOrNull;
    if (row != null) {
      response.user_hash = row['meta_file_hash'];
    }
    logger.fine('reading uploaded meta hashes... done.');

    return response;
  }

  List<String> _sqlInit() {
    return [
      _sqlCreateChatTable,
      _sqlCreateTableMessage,
      _sqlCreateTableUser,
      _sqlCreateIndexMessageChatIdMessageId,
      _sqlCreateIpfsUploadTable,
      _sqlCreateIpfsHashTable,
      _sqlCreateIndexIpfsHashTableName,
    ];
  }

  String _sqlSelectDataForDump(String tableName) {
    if (tableName == 'chat') {
      return _sqlSelectChatsForDump;
    } else if (tableName == 'message') {
      return _sqlSelectMessagesForDump;
    } else {
      return _sqlSelectUsersForDump;
    }
  }

  static const _sqlCreateChatTable = '''
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

  static const _sqlCreateTableMessage = '''
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

  static const _sqlCreateTableUser = '''
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

  static const _sqlCreateIpfsUploadTable = '''
CREATE TABLE IF NOT EXISTS ipfs_upload (
  table_name TEXT UNIQUE ON CONFLICT IGNORE NOT NULL,
  last_exported_id INTEGER,
  last_uploaded_id INTEGER,
  meta_file_hash TEXT,
  created_at TEXT,
  updated_at TEXT
);
''';

  static const _sqlCreateIpfsHashTable = '''
CREATE TABLE IF NOT EXISTS ipfs_hash (
  table_name TEXT,
  file_hash TEXT,
  created_at TEXT,
  updated_at TEXT
);
''';

  static const _sqlCreateIndexIpfsHashTableName = '''
CREATE INDEX IF NOT EXISTS idx_ipfs_hash_table_name ON
  ipfs_hash(table_name);
''';

  static const _sqlInitIpfsUploadTable = '''
INSERT INTO ipfs_upload
  (table_name, last_exported_id, last_uploaded_id, created_at, updated_at)
VALUES
  (?, ?, ?, ?, ?);
''';

  static const _sqlCreateIndexMessageChatIdMessageId = '''
CREATE UNIQUE INDEX IF NOT EXISTS idx_message_chat_id_message_id ON
  message(chat_id, id);
''';

  static const _sqlInsertMessage = '''
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

  static const _sqlSelectChat = '''
SELECT
  *
FROM
  chat 
WHERE 
  username = ?;
''';

  static const _sqlSelectIpfsUpload = '''
SELECT
  a.*
FROM
  ipfs_upload a
WHERE
  a.table_name = ?;
''';

  static const _sqlUpdateIpfsUploadLastExportedId = '''
UPDATE
  ipfs_upload
SET
  last_exported_id = ?
WHERE
  table_name = ?;
''';

  static const _sqlUpdateIpfsUploadLastUploadedId = '''
UPDATE
  ipfs_upload
SET
  last_uploaded_id = last_exported_id
WHERE
  table_name = ?;
''';

  static const _sqlInsertIpfsHash = '''
INSERT INTO
  ipfs_hash (
    table_name,
    file_hash,
    created_at,
    updated_at
  )
VALUES
  (?, ?, ?, ?)
''';

  static const _sqlUpdateIpfsUploadMetaFileHash = '''
UPDATE
  ipfs_upload
SET
  meta_file_hash = ?
WHERE
  table_name = ?;
''';

  static const _sqlSelectChatsForDump = '''
SELECT
  a.*,
  a.rowid
FROM
  chat a
WHERE
  a.rowid > ?
ORDER BY
  a.rowid ASC;
''';

  static const _sqlSelectMessagesForDump = '''
SELECT
  a.*,
  a.rowid
FROM
  message a
WHERE
  a.rowid > ?
ORDER BY
  a.rowid ASC;
''';

  static const _sqlSelectUsersForDump = '''
SELECT
  a.*,
  a.id rowid
FROM
  user a
WHERE
  a.id > ?
ORDER BY
  a.id ASC;
''';

  static const _sqlSelectMetaForDump = '''
SELECT
  a.*,
  a.rowid
FROM
  ipfs_hash a
WHERE
  a.table_name = ?
ORDER BY
  a.rowid ASC;
''';

  static const _sqlInsertChat = '''
INSERT INTO
  chat (username, created_at, updated_at)
VALUES (?, ?, ?);
''';

  static const _sqlUpdateChat = '''
UPDATE 
  chat
SET
  id = ?, title = ?, updated_at = ?
WHERE
  username = ?;
''';

  static const _sqlUpdateChatMemberCount = '''
UPDATE
  chat
SET
  member_count = ?, updated_at = ?
WHERE
  username = ?;
''';

  static const _sqlUpdateChatBotCount = '''
UPDATE
  chat
SET
  bot_count = ?, updated_at = ?
WHERE username = ?;
''';

  static const _sqlUpdateChatMemberOnlineCount = '''
UPDATE
  chat
SET
  member_online_count = ?, updated_at = ?
WHERE username = ?;
''';

  static const _sqlBlacklistChat = '''
UPDATE
  chat
SET
  blacklisted = 1, blacklist_reason = ?, updated_at = ?
WHERE username = ?;
''';

  static const _sqlSelectMaxMessageId = '''
SELECT
  max(id) id
FROM
  message
WHERE
  chat_id = ?
  AND date >= ?;
''';

  static const _sqlInsertUser = '''
INSERT INTO
  user (user_id, created_at, updated_at)
VALUES (?, ?, ?);
''';

  static const _sqlUpdateUser = '''
UPDATE
  user
SET
  first_name = ?, last_name = ?, username = ?,
  bot = ?, verified = ?, scam = ?, fake = ?
WHERE
  user_id = ?;
''';

  bool _dbErrorHandler(SqliteException error, String operation) {
    // return true for retry or false for exiting
    // Codes that were chosen for retry
    // 1 - SQLite generic error
    // 5 - SQLite engine currently busy
    // 261 - indicates that an operation could not continue because another process is busy recovering a WAL mode database file
    // 266 - indicating an I/O error in the VFS layer while trying to read from a file on disk
    switch (error.resultCode) {
      case 1:
        logger.fine(
            "[DB Exception within ${operation}] generic error -> ${error}");
        return true;
      case 2:
        logger.fine(
            "[DB Exception within ${operation}] internal error -> ${error}");
        return false;
      case 3:
        logger.fine(
            "[DB Exception within ${operation}] internal error -> ${error}");
        return false;
      case 4:
        logger.fine(
            "[DB Exception within ${operation}] unable to open SQLite file -> ${error}");
        return false;
      case 5:
        logger.fine(
            "[DB Exception within ${operation}] SQLite Engine currently busy -> ${error}");
        return true;
      case 6:
        logger.fine(
            "[DB Exception within ${operation}] conflict on the database connection -> ${error}");
        return false;
      case 7:
        logger.fine(
            "[DB Exception within ${operation}] SQLite was unable to allocate all the memory it needed for operation -> ${error}");
        return false;
      case 8:
        logger.fine(
            "[DB Exception within ${operation}] SQLite readonly error, current database connection does not have write permissions -> ${error}");
        return false;
      case 9:
        logger.fine(
            "[DB Exception within ${operation}] operation was interrupted -> ${error}");
        return false;
      case 10:
        logger.fine(
            "[DB Exception within ${operation}] operation could not finish because of an OS reported I/O error -> ${error}");
        return false;
      case 11:
        logger.fine(
            "[DB Exception within ${operation}] database file is corrputed -> ${error}");
        return false;
      case 12:
        logger.fine(
            "[DB Exception within ${operation}] SQLite not found -> ${error}");
        return false;
      case 13:
        logger.fine(
            "[DB Exception within ${operation}] write could not be completed, disk is full -> ${error}");
        return false;
      case 14:
        logger
            .fine("[DB Exception within ${operation}] API misuse -> ${error}");
        return false;
      case 17:
        logger
            .fine("[DB Exception within ${operation}] API misuse -> ${error}");
        return false;
      case 19:
        logger.fine(
            "[DB Exception within ${operation}] SQLite database schema has changed -> ${error}");
        return false;
      case 20:
        logger.fine(
            "[DB Exception within ${operation}] SQLite datatype mismatch -> ${error}");
        return false;
      case 21:
        logger.fine(
            "[DB Exception within ${operation}] SQLite misuse, interfaced with SQLite interface in a way that is undefined or unsupported -> ${error}");
        return false;
      case 23:
        logger.fine(
            "[DB Exception within ${operation}] authorization failed -> ${error}");
        return false;
      case 261:
        logger.fine(
            "[DB Exception within ${operation}] SQLite could not continue with operation because it is busy recovering WAL mode db file -> ${error}");
        return true;
      case 266:
        logger.fine(
            "[DB Exception within ${operation}] I/O error in the VFS layer while trying to read from a file on disk -> ${error}");
        return true;
      case 279:
        logger.fine(
            "[DB Exception within ${operation}] lacking sufficient authorization -> ${error}");
        return false;
      default:
        logger.fine("[DB Exception within ${operation}] error -> ${error}");
        return false;
    }
  }
}

class DbMsgRequest extends IsolateMsgRequest {
  DbMsgRequest({super.replySendPort});
}

class DbMsgResponse extends IsolateMsgResponse {
  SqliteException? exception;
  String? operationName;
  DbMsgResponse({this.exception, this.operationName});
}

class DbMsgRequestOpen extends DbMsgRequest {
  DbMsgRequestOpen({super.replySendPort});
}

class DbMsgResponseOpen extends DbMsgResponse {
  DbMsgResponseOpen({super.exception, super.operationName});
}

class DbMsgRequestMigrate extends DbMsgRequest {
  DbMsgRequestMigrate({super.replySendPort});
}

class DbMsgResponseMigrate extends DbMsgResponse {
  DbMsgResponseMigrate({super.exception, super.operationName});
}

class DbMsgRequestAddChats extends DbMsgRequest {
  final List<String> usernames;
  DbMsgRequestAddChats({super.replySendPort, required this.usernames});
}

class DbMsgResponseAddChats extends DbMsgResponse {
  DbMsgResponseAddChats({super.exception, super.operationName});
}

class DbMsgRequestBlacklistChat extends DbMsgRequest {
  final String username;
  final String reason;
  DbMsgRequestBlacklistChat({
    super.replySendPort,
    required this.username,
    required this.reason,
  });
}

class DbMsgResponseBlacklistChat extends DbMsgResponse {
  DbMsgResponseBlacklistChat({super.exception, super.operationName});
}

class DbMsgRequestUpdateChat extends DbMsgRequest {
  final String username;
  final Chat chat;
  DbMsgRequestUpdateChat({
    super.replySendPort,
    required this.username,
    required this.chat,
  });
}

class DbMsgResponseUpdateChat extends DbMsgResponse {
  DbMsgResponseUpdateChat({super.exception, super.operationName});
}

class DbMsgRequestUpdateChatMembersCount extends DbMsgRequest {
  final String username;
  final int membersCount;
  DbMsgRequestUpdateChatMembersCount({
    super.replySendPort,
    required this.username,
    required this.membersCount,
  });
}

class DbMsgResponseUpdateChatMembersCount extends DbMsgResponse {
  DbMsgResponseUpdateChatMembersCount({super.exception, super.operationName});
}

class DbMsgRequestUpdateChatMembersBotsCount extends DbMsgRequest {
  final String username;
  final int membersCount;
  DbMsgRequestUpdateChatMembersBotsCount({
    super.replySendPort,
    required this.username,
    required this.membersCount,
  });
}

class DbMsgResponseUpdateChatMembersBotsCount extends DbMsgResponse {
  DbMsgResponseUpdateChatMembersBotsCount(
      {super.exception, super.operationName});
}

class DbMsgRequestUpdateChatMembersOnlineCount extends DbMsgRequest {
  final String username;
  final int membersCount;
  DbMsgRequestUpdateChatMembersOnlineCount({
    super.replySendPort,
    required this.username,
    required this.membersCount,
  });
}

class DbMsgResponseUpdateChatMembersOnlineCount extends DbMsgResponse {
  DbMsgResponseUpdateChatMembersOnlineCount(
      {super.exception, super.operationName});
}

class DbMsgRequestSelectMaxMessageId extends DbMsgRequest {
  final int chatId;
  final DateTime dateTimeFrom;
  DbMsgRequestSelectMaxMessageId({
    super.replySendPort,
    required this.chatId,
    required this.dateTimeFrom,
  });
}

class DbMsgResponseSelectMaxMessageId extends DbMsgResponse {
  int? id;
  DbMsgResponseSelectMaxMessageId(
      {required this.id, super.exception, super.operationName});
}

class DbMsgRequestAddMessage extends DbMsgRequest {
  final Message message;
  final int? onlineMemberCount;
  DbMsgRequestAddMessage({
    super.replySendPort,
    required this.message,
    required this.onlineMemberCount,
  });
}

class DbMsgResponseAddMessage extends DbMsgResponse {
  final bool added;
  DbMsgResponseAddMessage(
      {required this.added, super.exception, super.operationName});
}

class DbMsgRequestAddUser extends DbMsgRequest {
  final int userId;
  DbMsgRequestAddUser({super.replySendPort, required this.userId});
}

class DbMsgResponseAddUser extends DbMsgResponse {
  DbMsgResponseAddUser({super.exception, super.operationName});
}

class DbMsgRequestUpdateUser extends DbMsgRequest {
  final int userId;
  final User user;
  DbMsgRequestUpdateUser(
      {super.replySendPort, required this.userId, required this.user});
}

class DbMsgResponseUpdateUser extends DbMsgResponse {
  DbMsgResponseUpdateUser({super.exception, super.operationName});
}

class DbMsgResponseConstraintError extends DbMsgResponseAddUser {
  DbMsgResponseConstraintError({super.exception, super.operationName});
}

class DbMsgRequestSelectChatOnlineMemberCount extends DbMsgRequest {
  final String chatName;
  DbMsgRequestSelectChatOnlineMemberCount({
    super.replySendPort,
    required this.chatName,
  });
}

class DbMsgResponseSelectChatOnlineMemberCount extends DbMsgResponse {
  int? onlineMemberCount;
  DbMsgResponseSelectChatOnlineMemberCount({
    this.onlineMemberCount,
    super.exception,
    super.operationName,
  });
}

class DbMsgRequestDumpData extends DbMsgRequest {
  final String tableName;
  final String fileName;
  int? fromId;
  DbMsgRequestDumpData({
    super.replySendPort,
    required this.tableName,
    required this.fileName,
    this.fromId,
  });
}

class DbMsgResponseDumpData extends DbMsgResponse {
  final int count;
  DbMsgResponseDumpData({
    super.exception,
    super.operationName,
    required this.count,
  });
}

class DbMsgRequestUploadDataSucces extends DbMsgRequest {
  String tableName;
  String file_hash;
  DbMsgRequestUploadDataSucces({
    super.replySendPort,
    required this.tableName,
    required this.file_hash,
  });
}

class DbMsgResponseUploadDataSucces extends DbMsgResponse {
  DbMsgResponseUploadDataSucces({super.exception, super.operationName});
}

class DbMsgRequestDumpMeta extends DbMsgRequest {
  final String tableName;
  final String fileName;
  DbMsgRequestDumpMeta(
      {super.replySendPort, required this.tableName, required this.fileName});
}

class DbMsgResponseDumpMeta extends DbMsgResponse {
  final int count;
  DbMsgResponseDumpMeta({
    super.exception,
    super.operationName,
    required this.count,
  });
}

class DbMsgRequestUploadMetaSucces extends DbMsgRequest {
  String tableName;
  String file_hash;
  DbMsgRequestUploadMetaSucces({
    super.replySendPort,
    required this.tableName,
    required this.file_hash,
  });
}

class DbMsgResponseUploadMetaSucces extends DbMsgResponse {
  DbMsgResponseUploadMetaSucces({super.exception, super.operationName});
}

class DbMsgRequestGetUploadHashes extends DbMsgRequest {
  DbMsgRequestGetUploadHashes({super.replySendPort});
}

class DbMsgResponseGetUploadHashes extends DbMsgResponse {
  String? chat_hash;
  String? message_hash;
  String? user_hash;
  DbMsgResponseGetUploadHashes({
    super.exception,
    super.operationName,
    this.chat_hash,
    this.message_hash,
    this.user_hash,
  });
}
