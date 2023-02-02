import 'dart:isolate';
import 'package:collection/collection.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:logging/logging.dart';
import 'package:telegram_client/log.dart';
import 'package:td_json_client/td_json_client.dart';
import 'package:telegram_client/wrap_id.dart';
import 'dart:mirrors';
class Db {
  late final ReceivePort _isolateReceivePort;
  late final Stream<dynamic> _isolateReceivePortBroadcast;
  late final SendPort isolateSendPort;

  late final Log _log;

  final _logger = Logger('Db');

  Db({
    required Level logLevel,
  }) {
    _logger.level = logLevel;
  }

  Future<void> spawn({
    required Log log,
    required String dbPath,
  }) async {
    _log = log;

    _logger.onRecord.listen((event) {
      _log.isolateSendPort.send(event);
    });

    _isolateReceivePort = ReceivePort();
    _isolateReceivePortBroadcast = _isolateReceivePort.asBroadcastStream();

    _logger.fine('spawning DbIsolated...');
    await Isolate.spawn(
      Db._entryPointDB,
      DbIsolatedSpwanMessage(
        parentSendPort: _isolateReceivePort.sendPort,
        logSendPort: _log.isolateSendPort,
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

  Future<void> exit() async {
    isolateSendPort.send(DbMsgRequestExit(
      replySendPort: _isolateReceivePort.sendPort,
    ));
    await _isolateReceivePortBroadcast
        .where((event) => event is DbMsgResponseExit)
        .first;
    _isolateReceivePort.close();
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
        message.replySendPort?.send(
          performDbOperation<DbMsgResponseOpen>(
          () => _open(),  DbMsgResponseOpen));
      } else if (message is DbMsgRequestMigrate) {
        message.replySendPort?.send(_migrate());
      } else if (message is DbMsgRequestAddChats) {
        message.replySendPort?.send(
          performDbOperation<DbMsgResponseAddChats>(
          () => _addChats(message.usernames),  DbMsgResponseAddChats));

      } else if (message is DbMsgRequestBlacklistChat) {
        message.replySendPort?.send(_blacklistChat(
          username: message.username,
          reason: message.reason,
        ));
      } else if (message is DbMsgRequestUpdateChat) {
        message.replySendPort?.send(_updateChat(
          username: message.username,
          chat: message.chat,
        ));
      } else if (message is DbMsgRequestUpdateChatMembersCount) {
        message.replySendPort?.send(_updateChatMembersCount(
          username: message.username,
          memberCount: message.membersCount,
        ));
      } else if (message is DbMsgRequestUpdateChatMembersBotsCount) {
        message.replySendPort?.send(_updateChatMembersBotsCount(
          username: message.username,
          memberCount: message.membersCount,
        ));
      } else if (message is DbMsgRequestUpdateChatMembersOnlineCount) {
        message.replySendPort?.send(_updateChatMembersOnlineCount(
          username: message.username,
          memberCount: message.membersCount,
        ));
      } else if (message is DbMsgRequestSelectMaxMessageId) {
        message.replySendPort?.send(_selectMaxMessageId(
          chatId: message.chatId,
          dateTimeFrom: message.dateTimeFrom,
        ));
      } else if (message is DbMsgRequestAddMessage) {
        message.replySendPort?.send(_addMessage(
          message: message.message,
          online_member_count: message.onlineMemberCount,
        ));
      } else if (message is DbMsgRequestAddUser) {
        message.replySendPort?.send(_addUser(userId: message.userId));
      } else if (message is DbMsgRequestUpdateUser) {
        message.replySendPort
            ?.send(_updateUser(userId: message.userId, user: message.user));
      } else if (message is DbMsgRequestSelectChatOnlineMemberCount) {
        message.replySendPort?.send(_selectChatOnlineMemberCount(
          chatName: message.chatName,
        ));
      }
    });
  }

   
  dynamic performDbOperation<T>(
    Function dbOperation,
    Type returnType,
  ) {
    var retry = true;
    var count = 0;
    while (retry) {
      try {
        return dbOperation();
      } on SqliteException catch (exception) {
        var retry = _dbErrorHandler(exception, 'Performing DB Operation');
        if (retry == true) {
          if (++count == maxTries) {
            InstanceMirror instanceMirror = reflectClass(returnType).newInstance(Symbol.empty, []);
            return instanceMirror.reflectee..exception = exception;
          }
        } else {
          InstanceMirror instanceMirror = reflectClass(returnType).newInstance(Symbol.empty, []);
          return instanceMirror.reflectee..exception = exception;
        }
      }
    }
  }

  DbMsgResponseOpen? _open() {
      _logger.fine('opening...');
      db = sqlite3.open(this.dbPath);
      _logger.fine('opened.');
      return DbMsgResponseOpen();
  }

  // DbMsgResponseOpen? _open() {
  //   try {
  //     _logger.fine('opening...');
  //     db = sqlite3.open(this.dbPath);
  //     _logger.fine('opened.');
  //     return DbMsgResponseOpen();
  //   } on SqliteException catch (exception) {
  //     const operationName = "Open DB";
  //     _dbErrorHandler(exception, operationName);
  //     return DbMsgResponseOpen(exception: exception);
  //   }
  // }

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

  DbMsgResponseMigrate? _migrate() {
    try {
      _logger.fine('running migrations...');
      for (final sql in _sqlInit()) {
        db?.execute(sql);
      }
      _logger.fine('running migrations... done.');
      return DbMsgResponseMigrate();
    } on SqliteException catch (exception) {
      _dbErrorHandler(exception, "Migrating DB");
      return DbMsgResponseMigrate(
          exception: exception, operationName: "Migrating DB");
    }
  }

  DbMsgResponseAddChats? _addChats(List<String> usernames) {
    var retry = true;
    var count = 0;
    while (retry) {
      try {
        for (var username in usernames) {
          _logger.fine('adding chat $username...');
          final stmt = db?.prepare(
              'INSERT INTO chat (username, created_at, updated_at) VALUES (?, ?, ?)');
          stmt?.execute([
            username,
            DateTime.now().toUtc().toIso8601String(),
            DateTime.now().toUtc().toIso8601String(),
          ]);
          _logger.fine('added chat $username.');
          stmt?.dispose();
        }
        return DbMsgResponseAddChats();
      } on SqliteException catch (exception) {
        var retry = _dbErrorHandler(exception, 'Add Chats');
        if (retry == true) {
          _logger.info("Retry Count: ${count}");
          if (++count == maxTries) {
            return DbMsgResponseAddChats(
                exception: exception, operationName: "Add Chats");
          }
        } else {
          return DbMsgResponseAddChats(
              exception: exception, operationName: "Add Chats");
        }
      }
    }
  }

  DbMsgResponseUpdateChat? _updateChat({
    required String username,
    required Chat chat,
  }) {
    var retry = true;
    var count = 0;
    while (retry) {
      try {
        final stmt = db?.prepare(
            'UPDATE chat SET id = ?, title = ?, updated_at = ? WHERE username = ?;');

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
      } on SqliteException catch (exception) {
        var retry = _dbErrorHandler(exception, 'Updating Chat');
        if (retry == true) {
          _logger.info("Retry Count: ${count}");
          if (++count == maxTries) {
            return DbMsgResponseUpdateChat(
                exception: exception, operationName: 'Updating Chat');
          }
        } else {
          return DbMsgResponseUpdateChat(
              exception: exception, operationName: 'Updating Chat');
        }
      }
    }
  }

  DbMsgResponseUpdateChatMembersCount _updateChatMembersCount({
    required String username,
    required int memberCount,
  }) {
    var retry = true;
    var count = 0;
    while (retry) {
      try {
    final stmt = db?.prepare(
        'UPDATE chat SET member_count = ?, updated_at = ? WHERE username = ?;');

    _logger.fine('updating chat $username, members count $memberCount...');
    stmt?.execute([
      memberCount,
      DateTime.now().toUtc().toIso8601String(),
      username,
    ]);
    _logger.fine('updated chat $username, members count $memberCount.');

        stmt?.dispose();
        return DbMsgResponseUpdateChatMembersCount();
      } on SqliteException catch (exception) {
        var retry = _dbErrorHandler(exception, 'Updating Chat Member Count');
        if (retry == true) {
          _logger.info("Retry Count: ${count}");
          if (++count == maxTries) {
            return DbMsgResponseUpdateChatMembersCount(
                exception: exception,
                operationName: 'Updating Chat Member Count');
          }
        } else {
          return DbMsgResponseUpdateChatMembersCount(
              exception: exception,
              operationName: 'Updating Chat Member Count');
        }
      }
    }
  }

  DbMsgResponseUpdateChatMembersBotsCount _updateChatMembersBotsCount({
    required String username,
    required int memberCount,
  }) {
    var retry = true;
    var count = 0;
    while (retry) {
      try {
    final stmt = db?.prepare(
        'UPDATE chat SET bot_count = ?, updated_at = ? WHERE username = ?;');

    _logger.fine('updating chat $username, bots count $memberCount...');
    stmt?.execute([
      memberCount,
      DateTime.now().toUtc().toIso8601String(),
      username,
    ]);
    _logger.fine('updated chat $username, bots count $memberCount.');

    stmt?.dispose();

        return DbMsgResponseUpdateChatMembersBotsCount();
      } on SqliteException catch (exception) {
        var retry =
            _dbErrorHandler(exception, 'Updating Chat Member Bots Count');
        if (retry == true) {
          _logger.info("Retry Count: ${count}");
          if (++count == maxTries) {
            return DbMsgResponseUpdateChatMembersBotsCount(
                exception: exception,
                operationName: 'Updating Chat Member Bots Count');
          }
        } else {
          return DbMsgResponseUpdateChatMembersBotsCount(
              exception: exception,
              operationName: 'Updating Chat Member Bots Count');
        }
      }
    }
  }

  DbMsgResponseUpdateChatMembersOnlineCount _updateChatMembersOnlineCount({
    required String username,
    required int memberCount,
  }) {

    final stmt = db?.prepare(
        'UPDATE chat SET member_online_count = ?, updated_at = ? WHERE username = ?;');

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
    var retry = true;
    var count = 0;
    while (retry) {
      try {
        final stmt = db?.prepare(
            'UPDATE chat SET blacklisted = 1, blacklist_reason = ?, updated_at = ? WHERE username = ?;');

        _logger.fine('blacklisting chat $username, reason $reason...');
        stmt?.execute([
          reason,
          DateTime.now().toUtc().toIso8601String(),
          username,
        ]);
        _logger.fine('blacklisted chat $username.');

        stmt?.dispose();

        return DbMsgResponseBlacklistChat();
      } on SqliteException catch (exception) {
        var retry = _dbErrorHandler(exception, 'Black Listing Chat');
        if (retry == true) {
          _logger.info("Retry Count: ${count}");
          if (++count == maxTries) {
            return DbMsgResponseBlacklistChat(
                exception: exception, operationName: 'Black Listing Chat');
          }
        } else {
          return DbMsgResponseBlacklistChat(
              exception: exception, operationName: 'Black Listing Chat');
        }
      }
    }
  }

  DbMsgResponseSelectMaxMessageId _selectMaxMessageId({
    required int chatId,
    required DateTime dateTimeFrom,
  }) {
    var retry = true;
    var count = 0;
    while (retry) {
      try {
        _logger.fine('reading last message id for $chatId...');

        final ResultSet? resultSet = db?.select(
            'SELECT max(id) id FROM message WHERE chat_id = ? AND date >= ?;', [
          chatId,
          dateTimeFrom.toIso8601String(),
        ]);

        int? id;
        if (resultSet != null && resultSet.isNotEmpty) {
          id = resultSet.first['id'];
          _logger.fine('found last message id $id for chat $chatId.');
        } else {
          _logger.fine('did not find last message id for chat $chatId.');
        }

        return DbMsgResponseSelectMaxMessageId(id: id);
      } on SqliteException catch (exception) {
        var retry = _dbErrorHandler(exception, 'Select Max Message Id');
        if (retry == true) {
          _logger.info("Retry Count: ${count}");
          if (++count == maxTries) {
            return DbMsgResponseSelectMaxMessageId(
                id: null,
                exception: exception,
                operationName: 'Select Max Message Id');
          }
        } else {
          return DbMsgResponseSelectMaxMessageId(
              id: null,
              exception: exception,
              operationName: 'Select Max Message Id');
        }
      }
    }
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
    var retry = true;
    var count = 0;
    while (retry) {
      try {
        final stmt = db?.prepare(_sqlInsertMessage());

        var userId = null;
        if (message.sender_id != null &&
            message.sender_id.runtimeType == MessageSenderUser) {
          userId = (message.sender_id as MessageSenderUser).user_id;
        }

        var text = null;
        if (message.content != null &&
            message.content.runtimeType == MessageText) {
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
      } on SqliteException catch (exception) {
        var retry = _dbErrorHandler(exception, "Adding Message");
        if (retry == true) {
          _logger.info("Retry Count: ${count}");
          if (++count == maxTries) {
            return DbMsgResponseAddMessage(
                added: false,
                exception: exception,
                operationName: "Adding Message");
          }
        } else {
          return DbMsgResponseAddMessage(
              added: false,
              exception: exception,
              operationName: "Adding Message");
        }
      }
    }
  }

  DbMsgResponseAddUser _addUser({required int userId}) {
    var retry = true;
    var count = 0;
    while (retry) {
      try {
        _logger.fine('Adding new user  $userId...');
        final sql = """
          INSERT INTO user (user_id) VALUES (?);
          """;
        final stmt = db?.prepare(sql);
        stmt?.execute([
          userId,
          DateTime.now().toUtc().toIso8601String(),
          DateTime.now().toUtc().toIso8601String(),
        ]);
        stmt?.dispose();
        _logger.fine('User $userId added');
        return DbMsgResponseAddUser();
      } on SqliteException catch (exception) {
        var retry = _dbErrorHandler(exception, "Adding User");
        if (retry == true) {
          _logger.info("Retry Count: ${count}");
          if (++count == maxTries) {
            return DbMsgResponseAddUser(exception: exception, operationName: "Adding User");
          }
        } else {
          if (exception.resultCode == 19) {
            return DbMsgResponseConstraintError(exception: exception, operationName: "Adding User");
          } else {
            return DbMsgResponseAddUser(
                exception: exception, operationName: "Adding User");
          }
        }
      }
    }
  }

  DbMsgResponseUpdateUser _updateUser(
      {required int userId, required User user}) {
    var retry = true;
    var count = 0;
    while (retry) {
      try {
        _logger.fine('Adding new user  $userId...');
        final sql = """
          UPDATE user SET first_name = ?, last_name = ?, username = ?, bot = ?, verified = ?, scam = ?, fake = ? WHERE user_id = ?;
          """;
        final stmt = db?.prepare(sql);
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
      } on SqliteException catch (exception) {
        var retry = _dbErrorHandler(exception, "Updating User");
        if (retry == true) {
          _logger.info("Retry Count: ${count}");
          if (++count == maxTries) {
            return DbMsgResponseUpdateUser(
                exception: exception, operationName: "Updating User");
          }
        } else {
          return DbMsgResponseUpdateUser(
              exception: exception, operationName: "Updating User");
        }
      }
    }
  }

  DbMsgResponseSelectChatOnlineMemberCount _selectChatOnlineMemberCount({
    required String chatName,
  }) {
    var retry = true;
    var count = 0;
    while (retry) {
      try {
        _logger.fine('reading member online count for $chatName...');

        final ResultSet? resultSet = db?.select(
          _sqlSelectChat(),
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
      } on SqliteException catch (exception) {
        var retry = _dbErrorHandler(
          exception,
          'Select Chat Online Member Count',
        );
        if (retry == true) {
          _logger.info("Retry Count: ${count}");
          if (++count == maxTries) {
            return DbMsgResponseSelectChatOnlineMemberCount(
                exception: exception,
                operationName: 'Select Chat Online Member Count');
          }
        } else {
          return DbMsgResponseSelectChatOnlineMemberCount(
              exception: exception,
              operationName: 'Select Chat Online Member Count');
        }
      }
    }
  }

  List<String> _sqlInit() {
    return [
      """
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
    """,
      """
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
    """,
      """
    CREATE TABLE IF NOT EXISTS user (
      id INTEGER NOT NULL PRIMARY KEY,
      user_id INTEGER UNIQUE NOT NULL,
      first_name TEXT,
      last_name TEXT,
      username TEXT,
      bot INTEGER,
      verified INTEGER,
      scam INTEGER,
      fake INTEGER
    );
    """,
      """
    CREATE UNIQUE INDEX IF NOT EXISTS idx_message_chat_id_message_id ON
      message(chat_id, id);
    """,
    ];
  }

  String _sqlInsertMessage() {
    return '''
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

  String _sqlSelectChat() {
    return '''
SELECT
  *
FROM
  chat 
WHERE 
  username = ?;
    ''';
  }

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
  final SqliteException? exception;
  final String? operationName;
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

class DbMsgResponseUpdateChatMembersCount extends DbMsgResponse {}

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
  DbMsgResponseAddUser({super.exception});
}

class DbMsgRequestUpdateUser extends DbMsgRequest {
  final int userId;
  final User user;

  DbMsgRequestUpdateUser(
      {super.replySendPort, required this.userId, required this.user});
}

class DbMsgResponseUpdateUser extends DbMsgResponse {
  DbMsgResponseUpdateUser({super.exception});
}

class DbMsgResponseConstraintError extends DbMsgResponseAddUser {
  DbMsgResponseConstraintError({super.exception});
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
