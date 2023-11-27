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

  static const addIfpsHashIdMin = '''
ALTER TABLE ipfs_hash
ADD COLUMN id_min INTEGER;
''';

  static const addIfpsHashIdMax = '''
ALTER TABLE ipfs_hash
ADD COLUMN id_max INTEGER;
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

  static const updateSupergroupFullInfo = '''
UPDATE
  chat
SET
  member_count = ?,
  description = ?,
  administrator_count = ?,
  restricted_count = ?,
  banned_count = ?,
  updated_at = ?
WHERE
  username = ?;
''';

  static const updateSupergroup = '''
UPDATE
  chat
SET
  is_verified = ?,
  is_scam = ?,
  is_fake = ?,
  updated_at = ?
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
  c.username,
  c.id,
  c.title,
  c.member_count, 
  c.member_online_count,
  c.bot_count,
  c.blacklisted,
  c.blacklist_reason,
  c.description,
  c.administrator_count,
  c.restricted_count,
  c.banned_count,
  c.is_verified,
  c.is_scam,
  c.is_fake
FROM
  ipfs_data a INNER JOIN
  ipfs_data_chat b on a.rowid = b.id_ipfs_data INNER JOIN
  chat c on b.rowid_chat = c.rowid
WHERE
  a.rowid = ?
''';

  static const selectAll = '''
SELECT
  a.*
FROM
  chat a
ORDER BY
  a.rowid ASC;
''';

  static const selectMaxRowid = '''
SELECT
  max(rowid) rowid
FROM
  chat;
''';

  static const selectPrepareExport = '''
SELECT
  a.rowid rowid_chat
FROM
  chat a
WHERE
  a.rowid > ?
ORDER BY
  a.rowid ASC; 
''';

  static const addColumnDescription = '''
ALTER TABLE chat
ADD COLUMN description TEXT;
''';

  static const addColumnAdministratorCount = '''
ALTER TABLE chat
ADD COLUMN administrator_count INTEGER;
''';

  static const addColumnRestrictedCount = '''
ALTER TABLE chat
ADD COLUMN restricted_count INTEGER;
''';

  static const addColumnBannedCount = '''
ALTER TABLE chat
ADD COLUMN banned_count INTEGER;
''';

  static const addColumnIsVerified = '''
ALTER TABLE chat
ADD COLUMN is_verified INTEGER;
''';

  static const addColumnIsScam = '''
ALTER TABLE chat
ADD COLUMN is_scam INTEGER;
''';

  static const addColumnIsFake = '''
ALTER TABLE chat
ADD COLUMN is_fake INTEGER;
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

//   static const selectForExport = '''
// SELECT
//   a.*,
//   a.rowid
// FROM
//   message a
// WHERE
//   a.rowid > ?
// ORDER BY
//   a.rowid ASC
// LIMIT
//   ?;
// ''';

  static const selectForExport = '''
SELECT
  c.chat_id,
  c.id,
  c.date,
  c.sender_id,
  c.sender_type,
  c.text,
  c.member_online_count,
  c.views,
  c.replies,
  c.forwards,
  c.reply_to_id
FROM
  ipfs_data a INNER JOIN
  ipfs_data_message b on a.rowid = b.id_ipfs_data INNER JOIN
  message c on b.rowid_message = c.rowid
WHERE
  a.rowid = ?
''';

  static const select = '''
SELECT
  a.*,
  a.rowid rowid
FROM
  message a
WHERE
  a.chat_id = ? AND
  a.id = ?;
''';

  static const selectPrepareExport = '''
SELECT
  a.rowid rowid_message,
  b.id rowid_user,
  date(a.date) date
FROM
  message a
LEFT JOIN
  "user" b on a.sender_id = b.user_id
WHERE
  a.rowid > ?
ORDER BY
  a.rowid ASC; 
''';

  static const createIndexSenderId = '''
CREATE INDEX IF NOT EXISTS idx_message_sender_id ON
  message(sender_id);
''';

  static const selectMaxRowid = '''
SELECT
  max(rowid) rowid
FROM
  message;
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
  c.user_id id,
  c.first_name,
  c.last_name,
  c.username,
  c.bot,
  c.verified,
  c.scam,
  c.fake
FROM
  ipfs_data a INNER JOIN
  ipfs_data_user b on a.rowid = b.id_ipfs_data INNER JOIN
  "user" c on b.rowid_user = c.id
WHERE
  a.rowid = ?
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
}

class SqlIpfsHash {
  static const insert = '''
INSERT INTO
  ipfs_hash (
    table_name,
    file_hash,
    id_min,
    id_max,
    created_at,
    updated_at
  )
VALUES
  (?, ?, ?, ?, ?, ?)
''';

  static const selectForExport = '''
SELECT
  a.file_hash,
  a.created_at,
  a.updated_at,
  a.rowid
FROM
  ipfs_hash a
WHERE
  a.table_name = ?
ORDER BY
  a.rowid ASC;
''';

  static const selectMessageForExport = '''
SELECT
  a.file_hash,
  a.created_at,
  a.updated_at,
  b.message_date_min,
  b.message_date_max,
  a.rowid
FROM
  ipfs_hash a
LEFT JOIN (
  SELECT
    aa.rowid,
    min(ab.date) message_date_min,
    max(ab.date) message_date_max
  FROM
    ipfs_hash aa,
    message ab
  WHERE
    aa.id_min <= ab.rowid
    AND aa.id_max >= ab.rowid
  GROUP BY
    aa.rowid
) b ON a.rowid = b.rowid
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

class SqlChatNew {
  static const createTable = '''
CREATE TABLE IF NOT EXISTS chat_new (
  username TEXT UNIQUE ON CONFLICT IGNORE NOT NULL,
  message_id_last INTEGER,
  status INTEGER DEFAULT 0, /* 0 - in progress; 1 - done reading history; */
  updated_at TEXT,
  created_at TEXT
);
''';

  static const insert = '''
INSERT INTO
  chat_new (username, created_at, updated_at)
VALUES (?, ?, ?)
ON CONFLICT DO NOTHING;
''';

  static const select = '''
SELECT
  *
FROM
  chat_new
WHERE
  username = ?;
''';

  static const update = '''
UPDATE
  chat_new
SET
  message_id_last = ?,
  status = ?
WHERE
  username = ?;
''';
}

class SqlIpfsMeta {
  static const createTable = '''
CREATE TABLE IF NOT EXISTS ipfs_meta (
  type TEXT UNIQUE ON CONFLICT IGNORE NOT NULL,
  cid TEXT,
  cid_old TEXT,
  created_at TEXT,
  updated_at TEXT
);
''';

  static const insert = '''
INSERT INTO ipfs_meta
  (type, cid, cid_old, created_at, updated_at)
VALUES
  (?, ?, ?, ?, ?)
ON CONFLICT DO NOTHING;
''';

  static const selectType = '''
SELECT
  a.*,
  a.rowid
FROM
  ipfs_meta a
WHERE
  a.type = ?;
''';

  static const selectExport = '''
SELECT
  a.cid
FROM
  ipfs_meta a
WHERE
  a.type = ?
ORDER BY
  a.rowid ASC;
''';

  static const updateCidOld = '''
UPDATE
  ipfs_meta
SET
  cid_old = cid,
  updated_at = ?
WHERE
  cid is not null;
''';

  static const updateCid = '''
UPDATE
  ipfs_meta
SET
  cid = ?,
  updated_at = ?
WHERE
  rowid = ?;
''';

  static const selectNextForExport = '''
SELECT
  a.*,
  a.rowid
FROM
  ipfs_meta a
WHERE
  a.cid is null
ORDER BY
  a.rowid ASC
LIMIT 1;
''';

  static const selectNextForUnpin = '''
SELECT
  a.*,
  a.rowid
FROM
  ipfs_meta a
WHERE
  a.cid is not null OR
  a.cid_old is not null
ORDER BY
  a.rowid ASC
LIMIt 1;
''';

  static const clearCidAll = '''
UPDATE
  ipfs_meta
SET
  cid = null,
  updated_at = ?;
''';

  static const clearCid = '''
UPDATE
  ipfs_meta
SET
  cid = null,
  updated_at = ?
WHERE
  rowid = ?;
''';

  static const clearCidOld = '''
UPDATE
  ipfs_meta
SET
  cid_old = null,
  updated_at = ?
WHERE
  rowid = ?;
''';

  static const clearCids = '''
UPDATE
  ipfs_meta
SET
  cid = null,
  cid_old = null,
  updated_at = ?;
''';
}

class SqlIpfsData {
  static const createTable = '''
CREATE TABLE IF NOT EXISTS ipfs_data (
  type TEXT,
  cid TEXT,
  cid_old TEXT,
  date TEXT,
  record_count INTEGER,
  created_at TEXT,
  updated_at TEXT
);
''';
  static const createIdxIpfsData = '''
CREATE INDEX IF NOT EXISTS idx_ipfs_data ON
  ipfs_data(type);
''';

  static const insert = '''
INSERT INTO ipfs_data
  (type, cid, cid_old, date, record_count, created_at, updated_at)
VALUES
  (?, ?, ?, ?, ?, ?, ?);
''';

  static const selectExportCidDate = '''
SELECT
  a.cid,
  a.date
FROM
  ipfs_data a
WHERE
  a.type = ? AND
  a.cid is not null
ORDER BY
  a.date ASC;
''';

  static const selectExportCid = '''
SELECT
  a.cid
FROM
  ipfs_data a
WHERE
  a.type = ? AND
  a.cid is not null
ORDER BY
  a.rowid ASC;
''';

  static const selectPrepare = '''
SELECT
  a.*,
  a.rowid
FROM
  ipfs_data a
WHERE
  a.type = ? AND
  a.record_count < ?
ORDER BY
  a.rowid ASC
LIMIT 1;
''';

  static const selectPrepareWithDate = '''
SELECT
  a.*,
  a.rowid
FROM
  ipfs_data a
WHERE
  a.type = ? AND
  a.date = ? AND
  a.record_count < ?
ORDER BY
  a.rowid ASC
LIMIT 1;
''';

  static const updateCidOld = '''
UPDATE
  ipfs_data
SET
  cid_old = cid,
  cid = null,
  updated_at = ?
WHERE
  rowid = ?;
''';

  static const updateRecordCountMessage = '''
UPDATE
  ipfs_data
SET
  record_count = (SELECT count(*) FROM ipfs_data_message WHERE id_ipfs_data = ?),
  updated_at = ?
WHERE
  rowid = ?;
''';

  static const updateRecordCountChat = '''
UPDATE
  ipfs_data
SET
  record_count = (SELECT count(*) FROM ipfs_data_chat WHERE id_ipfs_data = ?),
  updated_at = ?
WHERE
  rowid = ?;
''';

  static const updateRecordCountUser = '''
UPDATE
  ipfs_data
SET
  record_count = (SELECT count(*) FROM ipfs_data_user WHERE id_ipfs_data = ?),
  updated_at = ?
WHERE
  rowid = ?;
''';

  static const updateCidOldChat = '''
UPDATE
  ipfs_data
SET
  cid_old = cid,
  cid = null,
  updated_at = ?
WHERE
  type = 'chat' AND
  cid is not null;
''';

  static const selectNextForExport = '''
SELECT
  a.*,
  a.rowid
FROM
  ipfs_data a
WHERE
  a.cid is null AND
  a.record_count > 0
ORDER BY
  a.rowid ASC
LIMIT 1;
''';

  static const updateCid = '''
UPDATE
  ipfs_data
SET
  cid = ?,
  updated_at = ?
WHERE
  rowid = ?;
''';

  static const selectNextForUnpin = '''
SELECT
  a.*,
  a.rowid
FROM
  ipfs_data a
WHERE
  a.cid is not null OR
  a.cid_old is not null
ORDER BY
  a.rowid ASC
LIMIt 1;
''';

  static const clearCid = '''
UPDATE
  ipfs_data
SET
  cid = null,
  updated_at = ?
WHERE
  rowid = ?;
''';

  static const clearCidOld = '''
UPDATE
  ipfs_data
SET
  cid_old = null,
  updated_at = ?
WHERE
  rowid = ?;
''';

  static const clearCids = '''
UPDATE
  ipfs_data
SET
  cid = null,
  cid_old = null,
  updated_at = ?;
''';
}

class SqlIpfsDataMessage {
  static const createTable = '''
CREATE TABLE IF NOT EXISTS ipfs_data_message (
  id_ipfs_data INTEGER,
  rowid_message INTEGER,
  created_at TEXT
);
''';

  static const createIdxIpfsDataMessage = '''
CREATE UNIQUE INDEX IF NOT EXISTS idx_ipfs_data_message ON
  ipfs_data_message(id_ipfs_data, rowid_message);
''';

  static const selectRowidMessageMax = '''
SELECT
  max(rowid_message) rowid_message
FROM
  ipfs_data_message;
''';

  static const insert = '''
INSERT INTO ipfs_data_message
  (id_ipfs_data, rowid_message, created_at)
VALUES
  (?, ?, ?)
ON CONFLICT DO NOTHING;
''';
}

class SqlIpfsDataUser {
  static const createTable = '''
CREATE TABLE IF NOT EXISTS ipfs_data_user (
  id_ipfs_data INTEGER,
  rowid_user INTEGER,
  created_at TEXT
);
''';

  static const createIdxIpfsDataUser = '''
CREATE UNIQUE INDEX IF NOT EXISTS idx_ipfs_data_user ON
  ipfs_data_user(id_ipfs_data, rowid_user);
''';

  static const insert = '''
INSERT INTO ipfs_data_user
  (id_ipfs_data, rowid_user, created_at)
VALUES
  (?, ?, ?)
ON CONFLICT DO NOTHING;
''';
}

class SqlIpfsDataChat {
  static const createTable = '''
CREATE TABLE IF NOT EXISTS ipfs_data_chat (
  id_ipfs_data INTEGER,
  rowid_chat INTEGER,
  created_at TEXT
);
''';

  static const createIdxIpfsDataChat = '''
CREATE UNIQUE INDEX IF NOT EXISTS idx_ipfs_data_chat ON
  ipfs_data_chat(id_ipfs_data, rowid_chat);
''';

  static const insert = '''
INSERT INTO ipfs_data_chat
  (id_ipfs_data, rowid_chat, created_at)
VALUES
  (?, ?, ?)
ON CONFLICT DO NOTHING;
''';

  static const selectRowidMessageMax = '''
SELECT
  max(rowid_chat) rowid_chat
FROM
  ipfs_data_chat;
''';
}
