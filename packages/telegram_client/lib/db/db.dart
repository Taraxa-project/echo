import 'dart:isolate';

import 'package:sqlite3/sqlite3.dart';
import 'package:logging/logging.dart';

import 'package:telegram_client/lg.dart';

class Db {
  // late final DB dbInstance;
  late final ReceivePort _isolateReceivePort;
  late final Stream<dynamic> _isolateReceivePortBroadcast;
  late final SendPort _isolateSendPort;
  // SendPort? isolateSendPort;
  String dbPath;

  late final Lg _lg;

  final _logger = Logger('Db');

  Db({required String this.dbPath}){}
 
  Future<void> spawn({
    required Lg lg,
  }) async {
    _lg = lg;

    _logger.onRecord.listen((event) {
      _lg.isolateSendPort.send(event);
    });

    _isolateReceivePort = ReceivePort();
    _isolateReceivePortBroadcast = _isolateReceivePort.asBroadcastStream();
    _isolateReceivePortBroadcast
        .where((event) => event is LogRecord)
        .listen((logRecord) {
      _lg.isolateSendPort.send(logRecord);
    });

    _logger.info('spawning DbIsolated...');
    await Isolate.spawn(
      Db._entryPointDB,
      [dbPath, this._isolateReceivePort.sendPort],
      debugName: runtimeType.toString()
    );

    _isolateSendPort = await _isolateReceivePortBroadcast.first;
  }

  static void _entryPointDB(List<dynamic> initialSpawnMessage) async {
    String dbPath = initialSpawnMessage[0];
    SendPort parentSendPort = initialSpawnMessage[1];

    final DbIsolated dbIsolated = DbIsolated(dbPath: dbPath, parentSendPort: parentSendPort);

    var receivePort = ReceivePort();
    parentSendPort.send(receivePort.sendPort);

    receivePort.listen((message) {
      print("db isolate got message: ${message}");

      if (message is DbExit){
        dbIsolated._logger.info('exiting...');
        receivePort.close();
        Isolate.exit();
      }
      else if (message is DbOpen){
        print('open db inside isolate');
        dbIsolated.open();
      }
      else if (message is DbClose){
        print('close db inside isolate');

        dbIsolated.close();
      }
      else if (message is DbMigrate){
        print('migrate db inside isolate');

        dbIsolated.migrate();
      }
      else if (message is DbSelectChats){
        print('selecting chats within isolate');
        parentSendPort.send(dbIsolated.selectChats());
      }
      else if (message[0] is DbAddChat){
        print('add chat db inside isolate');
        dbIsolated.addChat(message[1]);
      }
      else if (message[0] is DbSelectMaxMessageId) {
        print('select max message id db inside isolate, message1 ${message[1]}, message2 ${message[2]}');
        parentSendPort.send(dbIsolated.selectMaxMessageId(message[1], message[2]));
      }
      else if (message[0] is DbAddMessage){
        final chatId = message[1];
        final messageId = message[2];
        final date = message[3];
        final userId = message[4];
        final text = message[5];
        print('chatId ${chatId} and messageId ${messageId}, date ${date} , userId ${userId}');
        dbIsolated.addMessage(
            chatId: chatId,
            messageId: messageId,
            date: date,
            userId: userId,
            text: text);
      }
      else if (message[0] is DbUpdateChat){
        print('updating chats within isolate, args ${message[1]}, ${message[2]}, ${message[3]}');
        dbIsolated.updateChat(message[1], message[2], message[3]);
      }
    });
    dbIsolated._logger.info('spawned.');

  }

  Future<void> open() async {
    print("received db open, sending to isolate");
    _isolateSendPort.send(DbOpen());
  }

  Future<void> close() async {
    print("received db close, sending to isolate");
    _isolateSendPort.send(DbClose());
  }

  Future<void>  migrate() async {
    print("received db migrate, sending to isolate");
    _isolateSendPort.send(DbMigrate());
  }

  Future<void> addChat(String username) async {
    _isolateSendPort.send([DbAddChat(), username]);
  }

  Future<void> updateChat(String username, int id, String title) async  {
    _isolateSendPort.send([DbUpdateChat(), username, id, title]);
  }

  //this now needs to dynamic instead of List<int> since it now returns log statements instead of selectChat results
  Future<List<int>> selectChats() async {
    _isolateSendPort.send(DbSelectChats());
    var response = await _isolateReceivePortBroadcast.where((event) => event is IsolateSelectChats).first;
    return response.chats;
  }

  //this now needs to dynamic instead of int since it now returns log statements instead of selectMaxMessageId result
  Future<int?> selectMaxMessageId(int chatId, DateTime newerThan) async {
    _isolateSendPort.send([ DbSelectMaxMessageId(), chatId, newerThan]);
    var response = await _isolateReceivePortBroadcast.where((event) => event is IsolateMaxMessageId).first;
    return response.maxMessageId;
  }

  Future<void> addMessage(
      {required int chatId,
      required int messageId,
      required int date,
      int? userId,
      String? text}) async {
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






class DbIsolated{
  final String dbPath;
  Database? db;
  final _logger = Logger('DbIsolated');
  final SendPort parentSendPort;

  DbIsolated({
    required String this.dbPath,
    required this.parentSendPort
  }) {
    _logger.onRecord.listen((logRecord) {
      parentSendPort.send(logRecord);
    });
  }

  void open() {
    _logger.info('opening...');
    db = sqlite3.open(this.dbPath);
    _logger.info('opened.');
    print("opened sqlite");
    print(
        '${Isolate.current.debugName}:${runtimeType.toString()}:open');
  }

  void close() {
    _logger.info('closing...');
    db?.dispose();
    _logger.info('closed.');
  }

  void migrate() {
    _logger.info('running migrations...');
    for (final sql in sqlInit()) {
      db?.execute(sql);
    }
    _logger.info('running migrations... done.');
  }

  void addChat(String username) {
    final stmt =
        db?.prepare('INSERT INTO chat (username, created_at) VALUES (?, ?)');

    _logger.info('adding chat $username...');
    stmt?.execute([username, DateTime.now().toUtc().toIso8601String()]);
    _logger.info('added chat $username.');

    stmt?.dispose();
  }

  void updateChat(String username, int id, String title) {
    final stmt = db?.prepare(
        'UPDATE chat SET id = ?, title = ?, updated_at = ? WHERE username = ?;');

    _logger.info('updating chat $username, id $id...');
    stmt?.execute([
      id,
      title,
      DateTime.now().toUtc().toIso8601String(),
      username,
    ]);
    _logger.info('updated chat $username, id $id.');

    stmt?.dispose();
  }

  IsolateSelectChats selectChats() {
    _logger.info('reading chats...');
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
    _logger.info('found ${ids.length} chats.');
    return IsolateSelectChats(ids);
  }

  IsolateMaxMessageId selectMaxMessageId(int chatId, DateTime newerThan) {
    print('selecting max message id ${chatId}, datetime ${newerThan}');
    _logger.info('reading last message id for $chatId...');
    final ResultSet? resultSet = db?.select(
        'SELECT max(id) id FROM message WHERE chat_id = ? AND date >= ?;', [
      chatId,
      newerThan.toIso8601String(),
    ]);
    _logger.info('resultSet $resultSet...');   
    int? id;
    if (resultSet != null && resultSet.isNotEmpty) {
      id = resultSet.first['id'];
      _logger.info('found last message id $id for chat $chatId.');
    } else {
      _logger.info('did not find last message id for chat $chatId.');
    }
    return IsolateMaxMessageId(id);
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

class IsolateSelectChats {
  List<int> chats;
  IsolateSelectChats(this.chats);
}

class IsolateMaxMessageId {
  int? maxMessageId;
  IsolateMaxMessageId(this.maxMessageId);
}
