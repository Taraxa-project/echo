import 'dart:isolate';
import 'dart:io' as io;
import 'dart:convert';
import 'package:path/path.dart' as p;

import 'package:collection/collection.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:logging/logging.dart';
import 'package:td_json_client/td_json_client.dart';
import 'package:telegram_client/wrap_id.dart';

class Db {
  late final ReceivePort _isolateReceivePort;
  late final Stream<dynamic> _isolateReceivePortBroadcast;
  late SendPort isolateSendPort;

  final _logger = Logger('Db');

  Db() {
    _isolateReceivePort = ReceivePort();
    _isolateReceivePortBroadcast = _isolateReceivePort.asBroadcastStream();
  }

  Future<void> spawn({
    required String dbPath,
    required Level logLevel,
    required SendPort logSendPort,
  }) async {
    _logger.level = logLevel;
    _logger.onRecord.listen((event) {
      logSendPort.send(event);
    });

    _logger.fine('spawning DbIsolated...');
    await Isolate.spawn(
      Db._entryPointDB,
      DbIsolatedSpwanMessage(
        parentSendPort: _isolateReceivePort.sendPort,
        logSendPort: logSendPort,
        dbPath: dbPath,
        logLevel: _logger.level,
      ),
      debugName: runtimeType.toString(),
    );
    _logger.fine('spawned.');

    isolateSendPort = await _isolateReceivePortBroadcast.first;
  }

  static void _entryPointDB(DbIsolatedSpwanMessage initialSpawnMessage) {
    hierarchicalLoggingEnabled = true;

    final DbIsolated dbIsolated = DbIsolated(
      parentSendPort: initialSpawnMessage.parentSendPort,
      logSendPort: initialSpawnMessage.logSendPort,
      dbPath: initialSpawnMessage.dbPath,
      logLevel: initialSpawnMessage.logLevel,
    );
    dbIsolated.init();
  }

  Future<void> exit() async {
    isolateSendPort.send(DbMsgRequestExit(
      replySendPort: _isolateReceivePort.sendPort,
    ));
    await _isolateReceivePortBroadcast
        .firstWhere((event) => event is DbMsgResponseExit);
    _isolateReceivePort.close();
  }

  Future<void> open() async {
    isolateSendPort.send(DbMsgRequestOpen(
      replySendPort: _isolateReceivePort.sendPort,
    ));

    var response = await _isolateReceivePortBroadcast
        .where((event) => event is DbMsgResponseOpen)
        .first;

    if (response.exception != null) {
      throw response.exception;
    } else {
      _logger.info('DB Opened Successfully');
    }
  }

  Future<void> migrate() async {
    isolateSendPort.send(DbMsgRequestMigrate(
      replySendPort: _isolateReceivePort.sendPort,
    ));
    var response = await _isolateReceivePortBroadcast
        .where((event) => event is DbMsgResponseMigrate)
        .first;

    if (response.exception != null) {
      throw response.exception;
    } else {
      _logger.info('DB Migrated Successfully');
    }
  }
}

class DbIsolatedSpwanMessage {
  final SendPort parentSendPort;
  final SendPort logSendPort;
  final String dbPath;
  final Level logLevel;

  DbIsolatedSpwanMessage({
    required this.parentSendPort,
    required this.logSendPort,
    required this.dbPath,
    required this.logLevel,
  });
}

class DbIsolated {
  final _logger = Logger('DbIsolated');

  final SendPort parentSendPort;
  final SendPort logSendPort;

  late final ReceivePort receivePort;
  late final Stream<dynamic> receivePortBroadcast;

  final String dbPath;
  Database? db;

  static const maxTries = 3;

  DbIsolated({
    required this.parentSendPort,
    required this.logSendPort,
    required this.dbPath,
    required Level logLevel,
  }) {
    _logger.level = logLevel;
    _logger.onRecord.listen((logRecord) {
      logSendPort.send(logRecord);
    });
  }

  void init() {
    _initPorts();
    _initDispatch();
  }

  void _initPorts() {
    receivePort = ReceivePort();
    receivePortBroadcast = receivePort.asBroadcastStream();

    parentSendPort.send(receivePort.sendPort);
  }

  Future<void> _initDispatch() async {
    receivePortBroadcast.listen((message) {
      if (message is DbMsgRequestExit) {
        _logger.fine('exiting...');
        _exit(replySendPort: message.replySendPort);
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
      } else if (message is DbMsgRequestDumpTables) {
        message.replySendPort?.send(_retryDbOperation(
          () => _dumpTables(
            dumpPath: message.dumpPath,
            fileExtData: message.dumpExt,
          ),
          DbMsgResponseDumpTables(),
          'dump table locally',
        ));
      }
    });
  }

  DbMsgResponse _retryDbOperation(
    DbMsgResponse Function() dbOperation,
    DbMsgResponse dbMsgResponse,
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

    dbMsgResponse.operationName = operationName;
    dbMsgResponse.exception = exception;

    return dbMsgResponse;
  }

  DbMsgResponseOpen _open() {
    _logger.fine('opening...');
    db = sqlite3.open(this.dbPath);
    _logger.fine('opened.');
    return DbMsgResponseOpen();
  }

  Future<void> _exit({SendPort? replySendPort}) async {
    _logger.fine('closing DB...');
    db?.dispose();
    _logger.fine('closed.');

    replySendPort?.send(DbMsgResponseExit());

    await Future.delayed(const Duration(milliseconds: 10));
    _logger.fine('closing DB port');
    receivePort.close();
    Isolate.exit();
  }

  DbMsgResponseMigrate _migrate() {
    _logger.fine('running migrations...');
    for (final sql in _sqlInit()) {
      db?.execute(sql);
    }
    _logger.fine('running migrations... done.');
    return DbMsgResponseMigrate();
  }

  DbMsgResponseAddChats _addChats(List<String> usernames) {
    for (var username in usernames) {
      _logger.fine('adding chat $username...');
      final stmt = db?.prepare(_sqlInsertChat);
      stmt?.execute([
        username,
        DateTime.now().toUtc().toIso8601String(),
        DateTime.now().toUtc().toIso8601String(),
      ]);
      _logger.fine('added chat $username.');
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
    _logger.fine('updating chat $username, id $id...');

    stmt?.execute([
      id,
      chat.title,
      DateTime.now().toUtc().toIso8601String(),
      username,
    ]);
    _logger.fine('updated chat $username, id $id.');

    stmt?.dispose();

    return DbMsgResponseUpdateChat();
  }

  DbMsgResponseUpdateChatMembersCount _updateChatMembersCount({
    required String username,
    required int memberCount,
  }) {
    final stmt = db?.prepare(_sqlUpdateChatMemberCount);

    _logger.fine('updating chat $username, members count $memberCount...');
    stmt?.execute([
      memberCount,
      DateTime.now().toUtc().toIso8601String(),
      username,
    ]);
    _logger.fine('updated chat $username, members count $memberCount.');

    stmt?.dispose();
    return DbMsgResponseUpdateChatMembersCount();
  }

  DbMsgResponseUpdateChatMembersBotsCount _updateChatMembersBotsCount({
    required String username,
    required int memberCount,
  }) {
    final stmt = db?.prepare(_sqlUpdateChatBotCount);

    _logger.fine('updating chat $username, bots count $memberCount...');
    stmt?.execute([
      memberCount,
      DateTime.now().toUtc().toIso8601String(),
      username,
    ]);
    _logger.fine('updated chat $username, bots count $memberCount.');

    stmt?.dispose();

    return DbMsgResponseUpdateChatMembersBotsCount();
  }

  DbMsgResponseUpdateChatMembersOnlineCount _updateChatMembersOnlineCount({
    required String username,
    required int memberCount,
  }) {
    final stmt = db?.prepare(_sqlUpdateChatMemberOnlineCount);

    _logger.fine('updating chat $username, bots count $memberCount...');
    stmt?.execute([
      memberCount,
      DateTime.now().toUtc().toIso8601String(),
      username,
    ]);
    _logger.fine('updated chat $username, bots count $memberCount.');

    stmt?.dispose();

    return DbMsgResponseUpdateChatMembersOnlineCount();
  }

  DbMsgResponseBlacklistChat _blacklistChat({
    required String username,
    required String reason,
  }) {
    final stmt = db?.prepare(_sqlBlacklistChat);

    _logger.fine('blacklisting chat $username, reason $reason...');
    stmt?.execute([
      reason,
      DateTime.now().toUtc().toIso8601String(),
      username,
    ]);
    _logger.fine('blacklisted chat $username.');

    stmt?.dispose();

    return DbMsgResponseBlacklistChat();
  }

  DbMsgResponseSelectMaxMessageId _selectMaxMessageId({
    required int chatId,
    required DateTime dateTimeFrom,
  }) {
    _logger.fine('reading last message id for $chatId...');

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
      _logger.fine('found last message id $id for chat $chatId.');
    } else {
      _logger.fine('did not find last message id for chat $chatId.');
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
    _logger.fine('Adding new user  $userId...');
    final stmt = db?.prepare(_sqlInsertUser);
    stmt?.execute([
      userId,
      DateTime.now().toUtc().toIso8601String(),
      DateTime.now().toUtc().toIso8601String(),
    ]);
    stmt?.dispose();
    _logger.fine('User $userId added');
    return DbMsgResponseAddUser();
  }

  DbMsgResponseUpdateUser _updateUser(
      {required int userId, required User user}) {
    _logger.fine('Adding new user  $userId...');
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
    _logger.fine('User $userId added');
    return DbMsgResponseUpdateUser();
  }

  DbMsgResponseSelectChatOnlineMemberCount _selectChatOnlineMemberCount({
    required String chatName,
  }) {
    _logger.fine('reading member online count for $chatName...');

    final ResultSet? resultSet = db?.select(
      _sqlSelectChat,
      [chatName],
    );

    int? result;
    if (resultSet != null && resultSet.isNotEmpty) {
      result = resultSet.first['member_online_count'];
      _logger.fine('found member online count $result for chat $chatName.');
    } else {
      _logger.fine('did not find member online count for chat $chatName.');
    }

    return DbMsgResponseSelectChatOnlineMemberCount(
      onlineMemberCount: result,
    );
  }

  DbMsgResponseDumpTables _dumpTables({
    required String dumpPath,
    required String fileExtData,
  }) {
    PreparedStatement? stmt;
    ResultSet? rs;

    stmt = db?.prepare(_sqlSelectChatsForDump);
    rs = stmt?.select();
    if (rs != null) {
      _dumpResultSet(rs, dumpPath, 'chat.$fileExtData');
    }

    stmt = db?.prepare(_sqlSelectMessagesForDump);
    rs = stmt?.select();
    if (rs != null) {
      _dumpResultSet(rs, dumpPath, 'message.$fileExtData');
    }

    stmt = db?.prepare(_sqlSelectUsersForDump);
    rs = stmt?.select();
    if (rs != null) {
      _dumpResultSet(rs, dumpPath, 'user.$fileExtData');
    }

    stmt?.dispose();

    return DbMsgResponseDumpTables();
  }

  Future<void> _dumpResultSet(
    ResultSet rs,
    String dumpPath,
    String fileName,
  ) async {
    final file = new io.File(p.join(dumpPath, fileName));
    file.createSync();

    final sink = file.openWrite(mode: io.FileMode.write);

    sink.write(jsonEncode(rs.columnNames));
    sink.write('\n');

    for (var row in rs) {
      sink.write(jsonEncode(row.values));
      sink.write('\n');
    }

    await sink.flush();
    await sink.close();
  }

  List<String> _sqlInit() {
    return [
      _sqlCreateChatTable,
      _sqlCreateTableMessage,
      _sqlCreateTableUser,
      _sqlCreateIndexMessageChatIdMessageId,
    ];
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

  static const _sqlSelectChatsForDump = '''
SELECT
  *
FROM
  chat;
''';

  static const _sqlSelectMessagesForDump = '''
SELECT
  *
FROM
  message
''';

  static const _sqlSelectUsersForDump = '''
SELECT
  *
FROM
  user;
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
        _logger.fine(
            "[DB Exception within ${operation}] generic error -> ${error}");
        return true;
      case 2:
        _logger.fine(
            "[DB Exception within ${operation}] internal error -> ${error}");
        return false;
      case 3:
        _logger.fine(
            "[DB Exception within ${operation}] internal error -> ${error}");
        return false;
      case 4:
        _logger.fine(
            "[DB Exception within ${operation}] unable to open SQLite file -> ${error}");
        return false;
      case 5:
        _logger.fine(
            "[DB Exception within ${operation}] SQLite Engine currently busy -> ${error}");
        return true;
      case 6:
        _logger.fine(
            "[DB Exception within ${operation}] conflict on the database connection -> ${error}");
        return false;
      case 7:
        _logger.fine(
            "[DB Exception within ${operation}] SQLite was unable to allocate all the memory it needed for operation -> ${error}");
        return false;
      case 8:
        _logger.fine(
            "[DB Exception within ${operation}] SQLite readonly error, current database connection does not have write permissions -> ${error}");
        return false;
      case 9:
        _logger.fine(
            "[DB Exception within ${operation}] operation was interrupted -> ${error}");
        return false;
      case 10:
        _logger.fine(
            "[DB Exception within ${operation}] operation could not finish because of an OS reported I/O error -> ${error}");
        return false;
      case 11:
        _logger.fine(
            "[DB Exception within ${operation}] database file is corrputed -> ${error}");
        return false;
      case 12:
        _logger.fine(
            "[DB Exception within ${operation}] SQLite not found -> ${error}");
        return false;
      case 13:
        _logger.fine(
            "[DB Exception within ${operation}] write could not be completed, disk is full -> ${error}");
        return false;
      case 14:
        _logger
            .fine("[DB Exception within ${operation}] API misuse -> ${error}");
        return false;
      case 17:
        _logger
            .fine("[DB Exception within ${operation}] API misuse -> ${error}");
        return false;
      case 19:
        _logger.fine(
            "[DB Exception within ${operation}] SQLite database schema has changed -> ${error}");
        return false;
      case 20:
        _logger.fine(
            "[DB Exception within ${operation}] SQLite datatype mismatch -> ${error}");
        return false;
      case 21:
        _logger.fine(
            "[DB Exception within ${operation}] SQLite misuse, interfaced with SQLite interface in a way that is undefined or unsupported -> ${error}");
        return false;
      case 23:
        _logger.fine(
            "[DB Exception within ${operation}] authorization failed -> ${error}");
        return false;
      case 261:
        _logger.fine(
            "[DB Exception within ${operation}] SQLite could not continue with operation because it is busy recovering WAL mode db file -> ${error}");
        return true;
      case 266:
        _logger.fine(
            "[DB Exception within ${operation}] I/O error in the VFS layer while trying to read from a file on disk -> ${error}");
        return true;
      case 279:
        _logger.fine(
            "[DB Exception within ${operation}] lacking sufficient authorization -> ${error}");
        return false;
      default:
        _logger.fine("[DB Exception within ${operation}] error -> ${error}");
        return false;
    }
  }
}

abstract class DbMsg {}

abstract class DbMsgRequest extends DbMsg {
  final SendPort? replySendPort;
  DbMsgRequest({
    this.replySendPort,
  });
}

abstract class DbMsgResponse extends DbMsg {
  SqliteException? exception;
  String? operationName;
  DbMsgResponse({this.exception, this.operationName});
}

class DbMsgRequestOpen extends DbMsgRequest {
  DbMsgRequestOpen({
    super.replySendPort,
  });
}

class DbMsgResponseOpen extends DbMsgResponse {
  DbMsgResponseOpen({super.exception, super.operationName});
}

class DbMsgRequestExit extends DbMsgRequest {
  DbMsgRequestExit({
    super.replySendPort,
  });
}

class DbMsgResponseExit extends DbMsgResponse {}

class DbMsgRequestMigrate extends DbMsgRequest {
  DbMsgRequestMigrate({
    super.replySendPort,
  });
}

class DbMsgResponseMigrate extends DbMsgResponse {
  DbMsgResponseMigrate({super.exception, super.operationName});
}

class DbMsgRequestAddChats extends DbMsgRequest {
  final List<String> usernames;

  DbMsgRequestAddChats({
    super.replySendPort,
    required this.usernames,
  });
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
  }) {}
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

  DbMsgResponseSelectChatOnlineMemberCount(
      {this.onlineMemberCount, super.exception, super.operationName});
}

class DbMsgRequestDumpTables extends DbMsgRequest {
  final String dumpPath;
  final String dumpExt;

  DbMsgRequestDumpTables({
    super.replySendPort,
    required this.dumpPath,
    required this.dumpExt,
  });
}

class DbMsgResponseDumpTables extends DbMsgResponse {
  DbMsgResponseDumpTables({
    super.exception,
    super.operationName,
  });
}
