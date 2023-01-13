import 'dart:isolate';

import 'package:sqlite3/sqlite3.dart';
import 'package:logging/logging.dart';


class IsolateDB {
  // late final DB dbInstance;
  late final ReceivePort _isolateReceivePort;
  late final Stream<dynamic> _isolateReceivePortBroadcast;
  late final SendPort _isolateSendPort;
  SendPort? isolateSendPort;
  String dbPath;
  Logger? logger;

  IsolateDB(
    String dbPath,
    Logger? logger
  ) : dbPath = dbPath,
   logger = logger
    {}
 

  Future<void> createDBIsolate() async {
    _isolateReceivePort = ReceivePort();
    _isolateReceivePortBroadcast = _isolateReceivePort.asBroadcastStream();
    await Isolate.spawn(
      IsolateDB._entryPointDB,
      [dbPath, logger, this._isolateReceivePort.sendPort],
      debugName: runtimeType.toString()
    );

    _isolateSendPort = await _isolateReceivePortBroadcast.first;
  }

  static void _entryPointDB(List<dynamic> initialSpawnMessage) async {
    String dbPath = initialSpawnMessage[0];
    Logger logger = initialSpawnMessage[1];
    SendPort parentSendPort = initialSpawnMessage[2];

    final DB dbInstance = DB(dbPath: dbPath, logger: logger);

    var receivePort = ReceivePort();
    parentSendPort.send(receivePort.sendPort);

    receivePort.listen((message) {
      print("db isolate got message: ${message}");

      if (message is DbExit){
        receivePort.close();
        Isolate.exit();
      }
      else if (message is DbOpen){
        print('open db inside isolate');
        dbInstance.open();
      }
      else if (message is DbClose){
        print('close db inside isolate');

        dbInstance.close();
      }
      else if (message is DbMigrate){
        print('migrate db inside isolate');

        dbInstance.migrate();
      }
      else if (message is DbSelectChats){
        print('selecting chats within isolate');
        parentSendPort.send(dbInstance.selectChats());
      }
      else if (message[0] is DbAddChat){
        print('add chat db inside isolate');
        dbInstance.addChat(message[1]);
      }
      else if (message[0] is DbSelectMaxMessageId) {
        print('select max message id db inside isolate, message1 ${message[1]}, message2 ${message[2]}');
        parentSendPort.send(dbInstance.selectMaxMessageId(message[1], message[2]));
      }
      else if (message[0] is DbAddMessage){
        final chatId = message[1];
        final messageId = message[2];
        final date = message[3];
        final userId = message[4];
        final text = message[5];
        print('chatId ${chatId} and messageId ${messageId}, date ${date} , userId ${userId}');
        dbInstance.addMessage(
            chatId: message.chat_id,
            messageId: message.id,
            date: message.date,
            userId: userId,
            text: text);
      }
      else if (message[0] is DbUpdateChat){
        print('updating chats within isolate, args ${message[1]}, ${message[2]}, ${message[3]}');
        dbInstance.updateChat(message[1], message[2], message[3]);
      }
    });
  }

  void open() {
    print("received db open, sending to isolate");
    _isolateSendPort.send(DbOpen());
  }

  void close() {
    print("received db close, sending to isolate");
    _isolateSendPort.send(DbClose());
  }

  void  migrate() {
    print("received db migrate, sending to isolate");
    _isolateSendPort.send(DbMigrate());
  }

  Future<void> addChat(String username) async {
    _isolateSendPort.send([DbAddChat(), username]);
  }

  void updateChat(String username, int id, String title) {
    _isolateSendPort.send([DbUpdateChat(), username, id, title]);
  }

  Future<dynamic> selectChats() async {
    _isolateSendPort.send(DbSelectChats());

    var response = await _isolateReceivePortBroadcast.first;
    print('response ${response}');
    return response;
  }

  Future<int?> selectMaxMessageId(int chatId, DateTime newerThan) async {
    _isolateSendPort.send([ DbSelectMaxMessageId(), chatId, newerThan]);

    var response = await _isolateReceivePortBroadcast.first;
    return response;

  }

  void addMessage(
      {required int chatId,
      required int messageId,
      required int date,
      int? userId,
      String? text}) {
    _isolateSendPort.send([DbAddMessage(), chatId, messageId, date, userId, text]);
  }
}

abstract class DbOperation {}

class DBLogin extends DbOperation {}

class DbOpen extends DbOperation {}

class DbMigrate extends DbOperation {}

class DbClose extends DbOperation {}

class DbExit extends DbOperation {}

class DbUpdateChat extends DbOperation {}

class DbSelectChats extends DbOperation {}

class DbSelectMaxMessageId extends DbOperation {}

class DbAddMessage extends DbOperation {}

class DbAddChat extends DbOperation {}




class DB {
  final String dbPath;
  Database? db;
  Logger? logger;

  DB({
    required String this.dbPath,
    this.logger,
  });

  void open() {
    logger?.info('opening...');
    db = sqlite3.open(this.dbPath);
    logger?.info('opened.');
    print("opened sqlite");
    print(
        '${Isolate.current.debugName}:${runtimeType.toString()}:open');
  }

  void close() {
    logger?.info('closing...');
    db?.dispose();
    logger?.info('closed.');
    print("closed db");
  }

  void migrate() {
    logger?.info('running migrations...');
    for (final sql in sqlInit()) {
      db?.execute(sql);
    }
    logger?.info('running migrations... done.');
    print('ended migrations');
  }

  void addChat(String username) {
    final stmt =
        db?.prepare('INSERT INTO chat (username, created_at) VALUES (?, ?)');

    logger?.info('adding chat $username...');
    stmt?.execute([username, DateTime.now().toUtc().toIso8601String()]);
    logger?.info('added chat $username.');

    stmt?.dispose();
  }

  void updateChat(String username, int id, String title) {
    final stmt = db?.prepare(
        'UPDATE chat SET id = ?, title = ?, updated_at = ? WHERE username = ?;');

    logger?.info('updating chat $username, id $id...');
    stmt?.execute([
      id,
      title,
      DateTime.now().toUtc().toIso8601String(),
      username,
    ]);
    logger?.info('updated chat $username, id $id.');

    stmt?.dispose();
  }

  List<int?> selectChats() {
    print("reading chats");
    logger?.info('reading chats...');
    final ResultSet? resultSet =
        db?.select('SELECT id FROM chat ORDER BY created_at ASC;');

    print("result set: ${resultSet}");
    List<int> ids = [];
    if (resultSet != null) {
      for (final Row row in resultSet) {
        print('row ${row}');
        if (row['id'] != null){
          ids.add(row['id']);
        }
      }
    }
    print("found ids: ${ids}");
    // logger?.info('found ${ids.length} chats.');
    return ids;
  }

  int? selectMaxMessageId(int chatId, DateTime newerThan) {
    logger?.info('reading last message id for $chatId...');
    final ResultSet? resultSet = db?.select(
        'SELECT max(id) id FROM message WHERE chat_id = ? AND date >= ?;', [
      chatId,
      newerThan.toIso8601String(),
    ]);

    int? id;
    if (resultSet != null && resultSet.isNotEmpty) {
      id = resultSet.first['id'];
      logger?.info('found last message id $id for chat $chatId.');
    } else {
      logger?.info('did not find last message id for chat $chatId.');
    }

    return id;
  }

  void addMessage(
      {required int chatId,
      required int messageId,
      required int date,
      int? userId,
      String? text}) {
    final sql = """
      INSERT INTO message (chat_id, id, date, user_id, text, created_at, updated_at)
      VALUES (?, ?, ?, ?, ?, ?, ?) ON CONFLICT DO NOTHING;
      """;
    final stmt = db?.prepare(sql);
    stmt?.execute([
      chatId,
      messageId,
      DateTime.fromMillisecondsSinceEpoch(date * 1000)
          .toUtc()
          .toIso8601String(),
      userId,
      text,
      DateTime.now().toUtc().toIso8601String(),
      DateTime.now().toUtc().toIso8601String(),
    ]);
    stmt?.dispose();
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
}

class IsolateSelectChats {}
