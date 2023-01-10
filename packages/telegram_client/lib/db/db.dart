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

  void open() {
    logger?.info('opening...');
    db = sqlite3.open(this.dbPath);
    logger?.info('opened.');
  }

  void close() {
    logger?.info('closing...');
    db?.dispose();
    logger?.info('closed.');
  }

  void migrate() {
    logger?.info('running migrations...');
    for (final sql in sqlInit()) {
      db?.execute(sql);
    }
    logger?.info('running migrations... done.');
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

  List<int> selectChats() {
    logger?.info('reading chats...');
    final ResultSet? resultSet =
        db?.select('SELECT id FROM chat ORDER BY created_at ASC;');

    List<int> ids = [];
    if (resultSet != null) {
      for (final Row row in resultSet) {
        ids.add(row['id']);
      }
    }

    logger?.info('found ${ids.length} chats.');
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
