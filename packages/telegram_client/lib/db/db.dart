import 'dart:isolate';

import 'package:sqlite3/sqlite3.dart';
import 'package:logging/logging.dart';

class DB {
  final String dbPath;
  Database? db;
  Logger? logger;

  DB({
    required String this.dbPath,
    this.logger,
  });

  Future<void> open() async {
    final p = ReceivePort();
    await Isolate.spawn(_openIsolate, p.sendPort);
  }

  Future<void> _openIsolate(SendPort p) {
    logger?.info('opening...');
    db = sqlite3.open(this.dbPath);
    logger?.info('opened.');
    Isolate.exit(p);
  }

  Future<void> close() async {
    final p = ReceivePort();
    await Isolate.spawn(_closeIsolate, p.sendPort);
  }

  Future<void> _closeIsolate(SendPort p) {
    logger?.info('closing...');
    db?.dispose();
    logger?.info('closed.');
    Isolate.exit(p);
  }

  Future<void> migrate() async {
    final p = ReceivePort();
    await Isolate.spawn(_migrateIsolate, p.sendPort);
  }

  Future<void> _migrateIsolate(SendPort p) async {
    logger?.info('running migrations...');
    for (final sql in sqlInit()) {
      db?.execute(sql);
    }
    logger?.info('running migrations... done.');
    Isolate.exit(p);
  }

  Future<void> addChat(String username) async {
    final p = ReceivePort();
    await Isolate.spawn(_addChatIsolate, [p.sendPort, username]);
  }

  Future<void> _addChatIsolate(List<dynamic> args) async {
    SendPort responsePort = args[0];
    String username = args[1];
    final stmt =
        db?.prepare('INSERT INTO chat (username, created_at) VALUES (?, ?)');

    logger?.info('adding chat $username...');
    stmt?.execute([username, DateTime.now().toUtc().toIso8601String()]);
    logger?.info('added chat $username.');

    stmt?.dispose();
    Isolate.exit(responsePort);
  }

  Future<void> _updateChatIsolate(List<dynamic> args) async {
    SendPort responsePort = args[0];
    String username = args[1];
    int id = args[2];
    String title = args[3];

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
    Isolate.exit(responsePort);
  }

  Future<void> updateChat(String username, int id, String title) async {
    logger?.info('Updating chat $id with username $username');
    final p = ReceivePort();
    await Isolate.spawn(_updateChatIsolate, [p.sendPort, username, id, title]);
  }

  Future<List<int>> selectChats() async {
    final p = ReceivePort();
    
    await Isolate.spawn(_selectChatsIsolate, p.sendPort);
    return await p.first as List<int>;
  }
  
  Future<List<int>> _selectChatsIsolate(SendPort p) async{
    logger?.info('reading chats...');
    final ResultSet? resultSet =
        db?.select('SELECT id FROM chat ORDER BY created_at ASC;');

    List<int> ids = [];
    logger?.info('found ${resultSet} results.');
    if (resultSet != null) {
      for (final Row row in resultSet) {
        ids.add(row['id']);
      }
    }

    logger?.info('found ${ids.length} chats.');
    Isolate.exit(p, ids);
  }

  Future<int?> selectMaxMessageId(int chatId, DateTime newerThan) async {
    final p = ReceivePort();
    await Isolate.spawn(_selectMaxMessageIdIsolate, [p.sendPort, chatId, newerThan]);
    return await p.first as int?;
  }

  Future<int?> _selectMaxMessageIdIsolate(List<dynamic> args) {
    SendPort responsePort = args[0];
    int chatId = args[1];
    DateTime newerThan = args[2];

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

    Isolate.exit(responsePort, id);
  }

  Future<void> addMessage({required int chatId,
      required int messageId,
      required int date,
      int? userId,
      String? text}) async {
    final p = ReceivePort();
    await Isolate.spawn(_addMessageIsolate, [p.sendPort, messageId, date, userId, text]);
  }

  Future<void> _addMessageIsolate(List<dynamic> args) async {
    SendPort responsePort = args[0];
    String chatId = args[1];
    int messageId = args[2];
    int date = args[3];
    int? userId = args[4];
    String? text = args[5];
    
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
    Isolate.exit(responsePort);
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
