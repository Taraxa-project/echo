class SqlMigration {
  static const createChatTable = '''
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

  static const createTableMessage = '''
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

  static const createTableUser = '''
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

  static const createIpfsUploadTable = '''
CREATE TABLE IF NOT EXISTS ipfs_upload (
  table_name TEXT UNIQUE ON CONFLICT IGNORE NOT NULL,
  last_exported_id INTEGER,
  last_uploaded_id INTEGER,
  meta_file_hash TEXT,
  created_at TEXT,
  updated_at TEXT
);
''';

  static const createIpfsHashTable = '''
CREATE TABLE IF NOT EXISTS ipfs_hash (
  table_name TEXT,
  file_hash TEXT,
  created_at TEXT,
  updated_at TEXT
);
''';

  static const createIndexIpfsHashTableName = '''
CREATE INDEX IF NOT EXISTS idx_ipfs_hash_table_name ON
  ipfs_hash(table_name);
''';

  static const createIndexMessageChatIdMessageId = '''
CREATE UNIQUE INDEX IF NOT EXISTS idx_message_chat_id_message_id ON
  message(chat_id, id);
''';

  static const renameMessageUserIdToSenderId = '''
ALTER TABLE message
RENAME user_id TO sender_id;
''';

  static const addMessageSenderType = '''
ALTER TABLE message
ADD COLUMN sender_type TEXT;
''';
}

class SqlChat {
  static const insert = '''
INSERT INTO
  chat (username, created_at, updated_at)
VALUES (?, ?, ?);
''';

  static const blacklist = '''
UPDATE
  chat
SET
  blacklisted = 1, blacklist_reason = ?, updated_at = ?
WHERE username = ?;
''';

  static const update = '''
UPDATE 
  chat
SET
  id = ?, title = ?, updated_at = ?
WHERE
  username = ?;
''';

  static const updateMembersCount = '''
UPDATE
  chat
SET
  member_count = ?, updated_at = ?
WHERE
  username = ?;
''';

  static const updateMemberOnlineCount = '''
UPDATE
  chat
SET
  member_online_count = ?, updated_at = ?
WHERE username = ?;
''';

  static const updateBotCount = '''
UPDATE
  chat
SET
  bot_count = ?, updated_at = ?
WHERE username = ?;
''';

  static const select = '''
SELECT
  *
FROM
  chat 
WHERE 
  username = ?;
''';

  static const selectForExport = '''

SELECT
  a.*,
  a.rowid,
  c.file_hash file_hash_chat_read
FROM
  chat a LEFT JOIN (
	SELECT
		CAST(REPLACE(ba."table_name", 'chat.', '') AS INTEGER) chat_id,
	  max(rowid) rowid
	FROM
	  	ipfs_hash ba
	WHERE
		ba."table_name" like 'chat.%'
	GROUP BY
	  	ba."table_name"
  ) b on a.id = b.chat_id LEFT JOIN 
  ipfs_hash c ON b.rowid = c.rowid
WHERE
  a.rowid > ?
ORDER BY
  a.rowid ASC
LIMIT
  ?;
''';

  static const selectAll = '''
SELECT
  a.*
FROM
  chat a
ORDER BY
  a.rowid ASC;
''';
}

class SqlMessage {
  static const selectMaxIdFromDate = '''
SELECT
  max(id) id
FROM
  message
WHERE
  chat_id = ?
  AND date >= ?;
''';

  static const insert = '''
INSERT INTO message (
  chat_id, id, date, sender_id, sender_type, text, 
  member_online_count, views, replies, forwards, reply_to_id, 
  created_at, updated_at
)
VALUES (
  ?, ?, ?, ?, ?, ?,
  ?, ?, ?, ?, ?,
  ?, ?
) ON CONFLICT DO NOTHING;
''';

  static const selectForExport = '''
SELECT
  a.*,
  a.rowid
FROM
  message a
WHERE
  a.rowid > ?
ORDER BY
  a.rowid ASC
LIMIT
  ?;
''';
}

class SqlUser {
  static const select = '''
SELECT
  a.*
FROM
  user a
WHERE
  a.user_id = ?
''';

  static const insert = '''
INSERT INTO user (
  user_id, first_name, last_name, username,
  bot, verified, scam, fake, created_at, updated_at
)
VALUES (
  ?, ?, ?, ?,
  ?, ?, ?, ?, ?, ?);
''';

  static const selectForExport = '''
SELECT
  a.*,
  a.id rowid
FROM
  user a
WHERE
  a.id > ?
ORDER BY
  a.id ASC
LIMIT
  ?;
''';
}

class SqlIpfsUpload {
  static const insert = '''
INSERT INTO ipfs_upload
  (table_name, last_exported_id, last_uploaded_id, created_at, updated_at)
VALUES
  (?, ?, ?, ?, ?);
''';

  static const select = '''
SELECT
  a.*
FROM
  ipfs_upload a
WHERE
  a.table_name = ?;
''';

  static const updateLastExportedId = '''
UPDATE
  ipfs_upload
SET
  last_exported_id = ?,
  updated_at = ?
WHERE
  table_name = ?;
''';

  static const updateLastUploadedId = '''
UPDATE
  ipfs_upload
SET
  last_uploaded_id = last_exported_id,
  updated_at = ?
WHERE
  table_name = ?;
''';

  static const updateMetaFileHash = '''
UPDATE
  ipfs_upload
SET
  meta_file_hash = ?,
  updated_at = ?
WHERE
  table_name = ?;
''';

  static const selectMaxUpdatedAt = '''
SELECT
  max(updated_at) updated_at
FROM
  ipfs_upload
WHERE
  table_name = 'user' AND
  last_exported_id > 0
''';
}

class SqlIpfsHash {
  static const insert = '''
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

  static const selectForExport = '''
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
}

class SqlChatRead {
  static const createTable = '''
CREATE TABLE IF NOT EXISTS chat_read (
  id INTEGER NOT NULL PRIMARY KEY,
  chat_id INTEGER NOT NULL,
  message_count INTEGER,
  started_at TEXT,
  finished_at TEXT
);
''';

  static const createIndexChatId = '''
CREATE INDEX IF NOT EXISTS idx_chat_read_chat_id ON
  chat_read (chat_id);
''';

  static const createIndexStartedAt = '''
CREATE INDEX IF NOT EXISTS idx_chat_read_started_at ON
  chat_read (started_at);
''';

  static const createIndexFinishedAt = '''
CREATE INDEX IF NOT EXISTS idx_chat_read_finished_at ON
  chat_read (finished_at);
''';

  static const started = '''
INSERT INTO chat_read (
  chat_id,
  started_at
) VALUES (
  ?, ?
);
''';

  static const finished = '''
UPDATE
  chat_read
SET
  message_count = ?,
  finished_at = ?
WHERE
  id = ?
''';

  static const selectLast = '''
SELECT
  *
FROM
  chat_read
WHERE
  chat_id = ? AND
  started_at = ? AND
  message_count IS NULL AND
  finished_at IS NULL
ORDER BY
  id DESC
LIMIT 1;
''';

  static const selectForExport = '''
SELECT
  a.*,
  a.id rowid
FROM
  chat_read a
WHERE
  a.id > ? AND
  a.chat_id = ? AND
  a.started_at >= ?
ORDER BY
  a.id ASC
LIMIT
  ?;
''';
}
