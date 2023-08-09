import 'dart:convert';

import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:sqlite3/sqlite3.dart';
import 'package:postgres/postgres.dart';

import 'package:telegram_client/src/smart_contract/RegistryFacet.g.dart';
import 'package:telegram_client/src/smart_contract/DataGatheringFacet.g.dart';

void main() async {
  final now = DateTime.now().toUtc();

  final credentialsIngester =
      EthPrivateKey.fromHex(String.fromEnvironment('private_key_ingester'));

  final web3client = Web3Client(String.fromEnvironment('rpc_url'), Client());
  final contractRegistry = RegistryFacet(
    address: EthereumAddress.fromHex(
        String.fromEnvironment('ingester_contract_address')),
    client: web3client,
  );
  final contractData = DataGatheringFacet(
    address: EthereumAddress.fromHex(
        String.fromEnvironment('ingester_contract_address')),
    client: web3client,
  );

  final ingesterAddress = credentialsIngester.address;
  print({'ingesterAddress': ingesterAddress});

  final ingesterInfo =
      await contractRegistry.getIngesterWithGroups(ingesterAddress);
  print({'ingesterInfo': ingesterInfo});

  final ipfsHashesMeta = await contractData.getIpfsHashes(ingesterAddress);
  print({'ipfsHashesMeta': ipfsHashesMeta});

  final db = sqlite3.open(String.fromEnvironment('sqlite-db'));

  final ipfsHashMetaChat = ipfsHashesMeta[1];
  final ipfsHashMetaMessages = ipfsHashesMeta[2];

  final httpClient = http.Client();
  final ipfsParams = _buildIpfsParams();

  await _addChatsFromIpfs(httpClient, ipfsParams, ipfsHashMetaChat, now, db);
  await _addMessagesFromIpfs(
      httpClient, ipfsParams, ipfsHashMetaMessages, now, db);
  await _addMessagesFromPgsql(now, db, ingesterInfo[3]);

  db.dispose();
  httpClient.close();
  await web3client.dispose();
}

Future<void> _addChatsFromIpfs(http.Client httpClient, IpfsParams ipfsParams,
    String ipfsHash, DateTime now, Database db) async {
  db.execute(SqlChatIpfs.dropIndexUsername);
  db.execute(SqlChatIpfs.dropTable);
  db.execute(SqlChatIpfs.createTable);
  db.execute(SqlChatIpfs.createIndexUsername);

  var ipfsFile = await _ipfsCat(httpClient, ipfsParams, ipfsHash);
  var metas = ipfsFile.split('\n');

  for (var i = 1; i < metas.length; i++) {
    var metaJson = metas[i];
    if (metaJson.isEmpty) continue;
    var meta = jsonDecode(metaJson);
    var dateTimeUploaded = DateTime.parse(meta[2]);
    var dateDiff = now.difference(dateTimeUploaded).inDays;
    if (dateDiff <= 1) {
      // print({'chat meta': meta, 'dateDiff': dateDiff});
      await _insertChatsFromIpfs(httpClient, ipfsParams, meta[1], now, db);
    }
  }
}

Future<void> _insertChatsFromIpfs(http.Client httpClient, IpfsParams ipfsParams,
    String ipfsHash, DateTime now, Database db) async {
  var ipfsFile = await _ipfsCat(httpClient, ipfsParams, ipfsHash);
  var datas = ipfsFile.split('\n');

  final stmt = db.prepare(SqlChatIpfs.insert);

  for (var i = 1; i < datas.length; i++) {
    var dataJson = datas[i];
    if (dataJson.isEmpty) continue;
    var data = jsonDecode(dataJson);
    var params = data.getRange(0, data.length - 1);
    stmt.execute(params.toList());
    // print({'chat': data});
  }
}

Future<void> _addMessagesFromIpfs(http.Client httpClient, IpfsParams ipfsParams,
    String ipfsHash, DateTime now, Database db) async {
  db.execute(SqlMessageIpfs.dropIndexChatIdId);
  db.execute(SqlMessageIpfs.dropIndexDate);
  db.execute(SqlMessageIpfs.dropTable);
  db.execute(SqlMessageIpfs.createTable);
  db.execute(SqlMessageIpfs.createIndexChatIdId);
  db.execute(SqlMessageIpfs.createIndexDate);

  var ipfsFile = await _ipfsCat(httpClient, ipfsParams, ipfsHash);
  var metas = ipfsFile.split('\n');

  for (var i = 1; i < metas.length; i++) {
    var metaJson = metas[i];
    if (metaJson.isEmpty) continue;
    var meta = jsonDecode(metaJson);
    var dateTimeUploaded = DateTime.parse(meta[2]);
    var dateDiff = now.difference(dateTimeUploaded).inDays;
    if (dateDiff <= 1) {
      // print({'message meta': meta, 'dateDiff': dateDiff});
      await _insertMessagesFromIpfs(httpClient, ipfsParams, meta[1], now, db);
    }
  }
}

Future<void> _insertMessagesFromIpfs(http.Client httpClient,
    IpfsParams ipfsParams, String ipfsHash, DateTime now, Database db) async {
  var ipfsFile = await _ipfsCat(httpClient, ipfsParams, ipfsHash);
  var datas = ipfsFile.split('\n');

  final stmt = db.prepare(SqlMessageIpfs.insert);

  for (var i = 1; i < datas.length; i++) {
    var dataJson = datas[i];
    if (dataJson.isEmpty) continue;
    var data = jsonDecode(dataJson);
    var params = data.getRange(0, data.length - 1);
    stmt.execute(params.toList());
    // print({'message': data});
  }
  stmt.dispose();
}

Future<void> _addMessagesFromPgsql(
    DateTime now, Database db, List<dynamic> groups) async {
  db.execute(SqlMessagePgsql.dropIndexChatIdId);
  db.execute(SqlMessagePgsql.dropIndexDate);
  db.execute(SqlMessagePgsql.dropTable);
  db.execute(SqlMessagePgsql.createTable);
  db.execute(SqlMessagePgsql.createIndexChatIdId);
  db.execute(SqlMessagePgsql.createIndexDate);

  final pgsqlDb = PostgreSQLConnection(
    String.fromEnvironment('pgsql-host'),
    5432,
    String.fromEnvironment('pgsql-db'),
    username: String.fromEnvironment('pgsql-username'),
    password: String.fromEnvironment('pgsql-password'),
  );
  await pgsqlDb.open();

  final stmt = db.prepare(SqlMessagePgsql.insert);

  var index = 0;
  for (var group in groups) {
    index++;
    var chatRs = await pgsqlDb.query(SqPgsql.selectChatId,
        substitutionValues: {'group_username': group});
    for (final chatRow in chatRs) {
      var chatId = chatRow[0];

      print({'index': index, 'chatName': group, 'chatId': chatId});

      if (chatId == null) continue;

      var messageRs = await pgsqlDb.query(SqPgsql.selectMessages,
          substitutionValues: {
            'chat_id': chatId,
            'date': now.toUtc().subtract(Duration(days: 2))
          });
      for (final messageRow in messageRs) {
        // print(messageRow);
        var params = messageRow.map((e) {
          if (e is DateTime) {
            return e.toUtc().toIso8601String();
          } else {
            return e;
          }
        }).toList();

        stmt.execute(params);
      }
    }
  }

  stmt.dispose();

  await pgsqlDb.close();
}

Future<String> _ipfsCat(
    http.Client httpClient, IpfsParams ipfsParams, String ipfsHash) async {
  var ipfsUri = _buildIpfsUri(ipfsParams, '/api/v0/cat/$ipfsHash');
  var request = http.Request('POST', ipfsUri);
  var response =
      await httpClient.send(request).timeout(const Duration(seconds: 15));
  return await response.stream.bytesToString();
}

Uri _buildIpfsUri(
  IpfsParams ipfsParams,
  String ipfsUriPath, [
  Map<String, dynamic>? queryParameters,
]) {
  final authority = '${ipfsParams.ipfsHost}:${ipfsParams.ipfsPort}';
  if (ipfsParams.ipfsScheme == 'https') {
    return Uri.https(authority, ipfsUriPath, queryParameters);
  } else {
    return Uri.http(authority, ipfsUriPath, queryParameters);
  }
}

IpfsParams _buildIpfsParams() {
  return IpfsParams(
    String.fromEnvironment('ipfs-scheme'),
    String.fromEnvironment('ipfs-host'),
    String.fromEnvironment('ipfs-port'),
    // String.fromEnvironment('ipfs-username'),
    // String.fromEnvironment('ipfs-password'),
  );
}

class IpfsParams {
  String ipfsScheme;
  String ipfsHost;
  String ipfsPort;
  String? ipfsUsername;
  String? ipfsPassword;

  IpfsParams(
    this.ipfsScheme,
    this.ipfsHost,
    this.ipfsPort, [
    this.ipfsUsername,
    this.ipfsPassword,
  ]);
}

class SqlChatIpfs {
  static const dropIndexUsername = '''
DROP INDEX IF EXISTS idx_chat_ipfs_username;
''';

  static const dropTable = '''
DROP TABLE IF EXISTS chat_ipfs;
''';

  static const createTable = '''
CREATE TABLE IF NOT EXISTS chat_ipfs (
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

  static const createIndexUsername = '''
CREATE UNIQUE INDEX IF NOT EXISTS idx_chat_ipfs_username
ON chat_ipfs (username);
''';

  static const insert = '''
INSERT INTO
  chat_ipfs (
    username, id, title,
    member_count, member_online_count, bot_count,
    blacklisted, blacklist_reason,
    created_at, updated_at)
VALUES (
    ?, ?, ?,
    ?, ?, ?,
    ?, ?,
    ?, ?)
ON CONFLICT DO NOTHING;
''';
}

class SqlMessageIpfs {
  static const dropIndexChatIdId = '''
DROP INDEX IF EXISTS idx_message_ipfs_chat_id_id;
''';
  static const dropIndexDate = '''
DROP INDEX IF EXISTS idx_message_ipfs_date;
''';

  static const dropTable = '''
DROP TABLE IF EXISTS message_ipfs;
''';

  static const createTable = '''
CREATE TABLE IF NOT EXISTS message_ipfs (
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

  static const createIndexChatIdId = '''
CREATE UNIQUE INDEX IF NOT EXISTS idx_message_ipfs_chat_id
ON message_ipfs (chat_id, id);
''';

  static const createIndexDate = '''
CREATE INDEX IF NOT EXISTS idx_message_ipfs_date
ON message_ipfs (date);
''';

  static const insert = '''INSERT INTO message_ipfs (
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

class SqlMessagePgsql {
  static const dropIndexChatIdId = '''
DROP INDEX IF EXISTS idx_message_pgsql_chat_id_id;
''';
  static const dropIndexDate = '''
DROP INDEX IF EXISTS idx_message_pgsql_date;
''';

  static const dropTable = '''
DROP TABLE IF EXISTS message_pgsql;
''';

  static const createTable = '''
CREATE TABLE IF NOT EXISTS message_pgsql (
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

  static const createIndexChatIdId = '''
CREATE UNIQUE INDEX IF NOT EXISTS idx_message_pgsql_chat_id
ON message_pgsql (chat_id, id);
''';

  static const createIndexDate = '''
CREATE INDEX IF NOT EXISTS idx_message_pgsql_date
ON message_pgsql (date);
''';

  static const insert = '''INSERT INTO message_pgsql (
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

class SqPgsql {
  static const selectChatId = '''
SELECT
  chat_id
FROM
  chat
WHERE
  group_username = @group_username
''';

  static const selectMessages = '''
SELECT
  a.chat_id, a.message_id, a.date, a.user_id, a.text, 
  a.online_count, a.views, a.replies, a.forwards, a.reply_to_id, 
  a.created_at, a.updated_at
FROM
  message a
WHERE
  chat_id = @chat_id AND
  date >= @date
''';
}
