import 'dart:isolate';
import 'dart:math';

import 'package:sqlite3/sqlite3.dart';
import 'package:logging/logging.dart';
import 'package:telegram_client/log.dart';
import 'package:td_json_client/td_json_client.dart';
import 'package:telegram_client/telegram_client.dart';
import 'package:telegram_client/wrap_id.dart';
// import 'package:sqflite/sql.dart';

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
      ),
      debugName: runtimeType.toString(),
    );
    _logger.fine('spawned.');

    isolateSendPort = await _isolateReceivePortBroadcast.first;
  }

  static void _entryPointDB(DbIsolatedSpwanMessage initialSpawnMessage) {
    final DbIsolated dbIsolated = DbIsolated(
      parentSendPort: initialSpawnMessage.parentSendPort,
      logSendPort: initialSpawnMessage.logSendPort,
      dbPath: initialSpawnMessage.dbPath,
    );
    dbIsolated.init();
  }

  Future<void> open() async {
    isolateSendPort.send(DbMsgRequestOpen(
      replySendPort: _isolateReceivePort.sendPort,
    ));

    var response = await _isolateReceivePortBroadcast.where((event) => event is DbMsgResponseOpen).first;
    
    if (response.exceptionError != null) {
      exit();
    }
    else {
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
    var response = await _isolateReceivePortBroadcast.where((event) => event is DbMsgResponseMigrate).first;
    
    if (response.exceptionError != null) {
      _logger.severe('there is an exception error in migrate: ${response.exceptionError}');
      exit();
    }
    else {
      _logger.info('DB Migrated Successfully');
    }
  }
}

class DbIsolatedSpwanMessage {
  final SendPort parentSendPort;
  final SendPort logSendPort;
  final String dbPath;

  DbIsolatedSpwanMessage({
    required this.parentSendPort,
    required this.logSendPort,
    required this.dbPath,
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

  DbIsolated({
    required this.parentSendPort,
    required this.logSendPort,
    required this.dbPath,
  }) {
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
        message.replySendPort?.send(_open());
      } else if (message is DbMsgRequestMigrate) {
        message.replySendPort?.send(_migrate());
      } else if (message is DbMsgRequestAddChats) {
        var response;
         try{
          response = addChats(
          message.usernames);
        } on DbMsgResponseAddChats{
          print('caught response');
        } catch (exception) {
          print('exception ${exception}');
        }
        message.replySendPort?.send(response);
      } else if (message is DbMsgRequestUpdateChat) {
        message.replySendPort?.send(updateChat(
          username: message.username,
          chat: message.chat,
        ));
      } else if (message is DbMsgRequestSelectMaxMessageId) {
        message.replySendPort?.send(selectMaxMessageId(
          chatId: message.chatId,
          dateTimeFrom: message.dateTimeFrom,
        ));
      } else if (message is DbMsgRequestAddMessage) {
        message.replySendPort?.send(addMessage(
          message: message.message,
        ));
      }
    });
  }

  DbMsg? _open() {
     var maxTries = 3;
    var retry = true;
    var count = 0;
    while(retry) {
      try{
        _logger.fine('opening...');
        db = sqlite3.open(this.dbPath);
        _logger.fine('opened.');
        return DbMsgResponseOpen();
        } on SqliteException catch  (err) {
          var retry = dbErrorHandler(err);
          if (retry == true) {
            _logger.info("Retry Count: ${count}");
            if (++count == maxTries) return DbMsgResponseOpen(exceptionError: err);
          } else {
            return DbMsgResponseOpen(exceptionError: err);
          }
        }
    }
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

  DbMsg? _migrate() {
    var maxTries = 3;
    var retry = true;
    var count = 0;
    while(retry) {
      try{
        _logger.fine('running migrations...');
        for (final sql in sqlInit()) {
          db?.execute(sql);
        }
        _logger.fine('running migrations... done.');
        return DbMsgResponseMigrate();
        } on SqliteException catch  (err) {
          var retry = dbErrorHandler(err);
          if (retry == true) {
            _logger.info("Retry Count: ${count}");
            if (++count == maxTries) {
              return DbMsgResponseMigrate(exceptionError: err);
            }
          } else {
            return DbMsgResponseMigrate(exceptionError: err);
          }
        }
    }
  }

  DbMsg? addChats(List<String> usernames) {
    var maxTries = 3;
    var retry = true;
    var count = 0;
    while(retry) {
          try{
            for (var username in usernames) {
              _logger.fine('adding chat $username...');
              final stmt = db?.prepare(
                'blabla INSERT INTO chat (username, created_at, updated_at) VALUES (?, ?, ?)');
              stmt?.execute([
                username,
                DateTime.now().toUtc().toIso8601String(),
                DateTime.now().toUtc().toIso8601String(),
              ]);
              _logger.fine('added chat $username.');
              stmt?.dispose();
            }
            return DbMsgResponseAddChats();
        } on SqliteException catch  (err) {
          var retry = dbErrorHandler(err);
          if (retry == true) {
            _logger.info("Retry Count: ${count}");
            if (++count == maxTries) {
              throw SqliteException;//DbMsgResponseAddChats(exceptionError: err);
            }
          } else {
            throw SqliteException;//DbMsgResponseAddChats(exceptionError: err);
          }
        }
    }
  }

  DbMsg? updateChat({
    required String username,
    required Chat chat,
  }) {

    var maxTries = 3;
    var retry = true;
    var count = 0;
    while(retry) {
      try{
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
      } on SqliteException catch  (err) {
        var retry = dbErrorHandler(err);
        if (retry == true) {
          _logger.info("Retry Count: ${count}");
          if (++count == maxTries) {
            return DbMsgResponseUpdateChat(exceptionError: err);
          }
        } else {
          return DbMsgResponseUpdateChat(exceptionError: err);
        }
      }
    }
  }

  DbMsgResponseSelectMaxMessageId selectMaxMessageId({
    required int chatId,
    required DateTime dateTimeFrom,
  }) {
    var maxTries = 3;
    var retry = true;
    var count = 0;
    while(retry) {
      try{
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

        return DbMsgResponseSelectMaxMessageId(
          id: id,
        );
      } on SqliteException catch  (err) {
        var retry = dbErrorHandler(err);
        if (retry == true) {
          _logger.info("Retry Count: ${count}");
          if (++count == maxTries) {
            return DbMsgResponseSelectMaxMessageId(id: null, exceptionError: err);
          }
        } else {
          return DbMsgResponseSelectMaxMessageId(id: null,exceptionError: err);
        }
      }
    }
    
  }

  DbMsgResponseAddMessage addMessage({
    required Message message,
  }) {
    if (message.chat_id == null || message.id == null || message.date == null) {
      return DbMsgResponseAddMessage(
        added: false,
      );
    }
    final sql = """
      INSERT INTO message (chat_id, id, date, user_id, text, created_at, updated_at)
      VALUES (?, ?, ?, ?, ?, ?, ?) ON CONFLICT DO NOTHING;
      """;
    final stmt = db?.prepare(sql);

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

    stmt?.execute([
      WrapId.unwrapChatId(message.chat_id),
      WrapId.unwrapMessageId(message.id),
      DateTime.fromMillisecondsSinceEpoch(message.date! * 1000)
          .toUtc()
          .toIso8601String(),
      userId,
      text,
      DateTime.now().toUtc().toIso8601String(),
      DateTime.now().toUtc().toIso8601String(),
    ]);
    stmt?.dispose();

    return DbMsgResponseAddMessage(
      added: true,
    );
  }

  List<String> sqlInit() {
    return [
      """
    CREATE TABLE IF NOT EXISTS chat (
      username TEXT UNIQUE ON CONFLICT IGNORE NOT NULL,
      id INTEGER,
      title TEXT,
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
      created_at TEXT,
      updated_at TEXT
    );
    """,
      """
    CREATE UNIQUE INDEX IF NOT EXISTS idx_message_chat_id_message_id ON
      message(chat_id, id);
    """,
    ];
  }

  bool dbErrorHandler(SqliteException error) {
    // return true for retry or false for exiting
    // Codes that were chosen for retry
    // 1 - SQLite generic error
    // 5 - SQLite engine currently busy
    // 23 - Authorization failed
    // 261 - indicates that an operation could not continue because another process is busy recovering a WAL mode database file
    // 266 - indicating an I/O error in the VFS layer while trying to read from a file on disk
    // 279 - Lack sufficient authorization to do DB operation 
    switch (error.resultCode) {
      case 1:
        _logger.severe("[DB Exception] generic error -> ${error}");
        return true;
      case 2:
        _logger.severe("[DB Exception] internal error -> ${error}");
        return false; 
      case 3:
        _logger.severe("[DB Exception] internal error -> ${error}");
        return false;
      case 4:
        _logger.severe("[DB Exception] unable to open SQLite file -> ${error}");
        return false;
      case 5:
        _logger.severe("[DB Exception] SQLite Engine currently busy -> ${error}");
        return true;
      case 6:
        _logger.severe("[DB Exception] conflict on the database connection -> ${error}");
        return false;
      case 7:
        _logger.severe("[DB Exception] SQLite was unable to allocate all the memory it needed for operation -> ${error}");
        return false;
      case 8:
      _logger.severe("[DB Exception] SQLite readonly error, current database connection does not have write permissions -> ${error}");
      return false;
      case 9:
        _logger.severe("[DB Exception] operation was interrupted -> ${error}");
        return false;
      case 10:
        _logger.severe("[DB Exception] operation could not finish because of an OS reported I/O error -> ${error}");
        return false;
      case 11:
        _logger.severe("[DB Exception] database file is corrputed -> ${error}");
        return false;
      case 12:
        _logger.severe("[DB Exception] SQLite not found -> ${error}");
        return false;
      case 13:
        _logger.severe("[DB Exception] write could not be completed, disk is full -> ${error}");
        return false;
      case 14:
        _logger.severe("[DB Exception] API misuse -> ${error}");
        return false;
      case 17:
        _logger.severe("[DB Exception] API misuse -> ${error}");
        return false;
      case 19:
        _logger.severe("[DB Exception] SQLite database schema has changed -> ${error}");
        return false;
      case 20:
        _logger.severe("[DB Exception] SQLite datatype mismatch -> ${error}");
        return false;
      case 21:
        _logger.severe("[DB Exception] SQLite misuse, interfaced with SQLite interface in a way that is undefined or unsupported -> ${error}");
        return false;
      case 23:
        _logger.severe("[DB Exception] authorization failed -> ${error}");
        return true;
      case 261:
        _logger.severe("[DB Exception] SQLite could not continue with operation because it is busy recovering WAL mode db file -> ${error}");
        return true;
      case 266:
        _logger.severe("[DB Exception] I/O error in the VFS layer while trying to read from a file on disk -> ${error}");
        return true;
      case 279:
        _logger.severe("[DB Exception] lacking sufficient authorization -> ${error}");
        return true;
      default:
        _logger.severe("[DB Exception] error -> ${error}");
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
  final SqliteException? exceptionError;
  DbMsgResponse({
    this.exceptionError
  });
}

class DbMsgRequestOpen extends DbMsgRequest {
  DbMsgRequestOpen({
    super.replySendPort,
  });
}

class DbMsgResponseOpen extends DbMsgResponse {
  DbMsgResponseOpen({
    super.exceptionError,
  });
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
  DbMsgResponseMigrate({
    super.exceptionError
  });
}

class DbMsgRequestAddChats extends DbMsgRequest {
  final List<String> usernames;

  DbMsgRequestAddChats({
    super.replySendPort,
    required this.usernames,
  });
}

class DbMsgResponseAddChats extends DbMsgResponse {
  DbMsgResponseAddChats({
    super.exceptionError
  });
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
  DbMsgResponseUpdateChat({super.exceptionError});
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

  DbMsgResponseSelectMaxMessageId({
    required this.id,
    super.exceptionError
  });
}

class DbMsgRequestAddMessage extends DbMsgRequest {
  final Message message;

  DbMsgRequestAddMessage({
    super.replySendPort,
    required this.message,
  });
}

class DbMsgResponseAddMessage extends DbMsgResponse {
  final bool added;

  DbMsgResponseAddMessage({
    required this.added,
  });
}
