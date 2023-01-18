import 'dart:isolate';

import 'package:sqlite3/sqlite3.dart';
import 'package:logging/logging.dart';
import 'package:telegram_client/log.dart';
import 'package:td_json_client/td_json_client.dart';
import 'package:telegram_client/wrap_id.dart';

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
    await _isolateReceivePortBroadcast
        .where((event) => event is DbMsgResponseOpen)
        .first;
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
    await _isolateReceivePortBroadcast
        .where((event) => event is DbMsgResponseMigrate)
        .first;
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
        _exit(
          replySendPort: message.replySendPort,
        );
      } else if (message is DbMsgRequestOpen) {
        message.replySendPort?.send(_open());
      } else if (message is DbMsgRequestMigrate) {
        message.replySendPort?.send(_migrate());
      } else if (message is DbMsgRequestAddChats) {
        message.replySendPort?.send(addChats(
          message.usernames,
        ));
      } else if (message is DbMsgRequestBlacklistChat) {
        tgSendPort?.send(blacklistChat(
          username: message.username,
          reason: message.reason,
        ));
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

  DbMsgResponseOpen _open() {
    _logger.fine('opening...');
    db = sqlite3.open(this.dbPath);
    _logger.fine('opened.');

    return DbMsgResponseOpen();
  }

  Future<void> _exit({SendPort? replySendPort}) async {
    _logger.fine('closing...');
    db?.dispose();
    _logger.fine('closed.');

    replySendPort?.send(DbMsgResponseExit());

    await Future.delayed(const Duration(milliseconds: 10));

    receivePort.close();
    Isolate.exit();
  }

  DbMsgResponseMigrate _migrate() {
    _logger.fine('running migrations...');
    for (final sql in sqlInit()) {
      db?.execute(sql);
    }
    _logger.fine('running migrations... done.');
    return DbMsgResponseMigrate();
  }

  DbMsgResponseAddChats addChats(List<String> usernames) {
    final stmt = db?.prepare(
        'INSERT INTO chat (username, created_at, updated_at) VALUES (?, ?, ?)');

    for (var username in usernames) {
      _logger.fine('adding chat $username...');
      stmt?.execute([
        username,
        DateTime.now().toUtc().toIso8601String(),
        DateTime.now().toUtc().toIso8601String(),
      ]);
      _logger.fine('added chat $username.');
    }

    stmt?.dispose();

    return DbMsgResponseAddChats();
  }

  DbMsgResponseUpdateChat updateChat({
    required String username,
    required Chat chat,
  }) {
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
  }

  DbMsgResponseBlacklistChat blacklistChat({
    required String username,
    required String reason,
  }) {
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
  }

  DbMsgResponseSelectMaxMessageId selectMaxMessageId({
    required int chatId,
    required DateTime dateTimeFrom,
  }) {
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
      bot_count INTEGER,
      participants_count INTEGER,
      average_online_count INTEGER,
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
}

abstract class DbMsg {}

abstract class DbMsgRequest extends DbMsg {
  final SendPort? replySendPort;
  DbMsgRequest({
    this.replySendPort,
  });
}

abstract class DbMsgResponse extends DbMsg {}

class DbMsgRequestOpen extends DbMsgRequest {
  DbMsgRequestOpen({
    super.replySendPort,
  });
}

class DbMsgResponseOpen extends DbMsgResponse {}

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

class DbMsgResponseMigrate extends DbMsgResponse {}

class DbMsgRequestAddChats extends DbMsgRequest {
  final List<String> usernames;

  DbMsgRequestAddChats({
    super.replySendPort,
    required this.usernames,
  });
}

class DbMsgResponseAddChats extends DbMsgResponse {}

class DbMsgRequestBlacklistChat extends DbMsgRequest {
  final String username;
  final String reason;

  DbMsgRequestBlacklistChat({
    required this.username,
    required this.reason,
  });
}

class DbMsgResponseBlacklistChat extends DbMsgResponse {}

class DbMsgRequestUpdateChat extends DbMsgRequest {
  final String username;
  final Chat chat;

  DbMsgRequestUpdateChat({
    super.replySendPort,
    required this.username,
    required this.chat,
  });
}

class DbMsgResponseUpdateChat extends DbMsgResponse {}

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
  final int? id;

  DbMsgResponseSelectMaxMessageId({
    required this.id,
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
