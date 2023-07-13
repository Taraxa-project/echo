import 'dart:convert';
import 'dart:io' as io;

import 'package:logging/logging.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:sqlite3/sqlite3.dart';

import 'package:telegram_client/src/smart_contract/DataGatheringFacet.g.dart';

void main() async {
  hierarchicalLoggingEnabled = true;
  final report = Report();
  await report.run();
}

class Report {
  final _logger = Logger('Report');

  final _now = DateTime.now().toUtc();

  final _httpClient = http.Client();
  late final Web3Client _web3client;
  late final _ingesterContractAddress;
  late final DataGatheringFacet _contractDataGatheringFacet;
  late final IpfsParams _ipfsParams;
  late final Database _db;

  Report() {
    _ipfsParams = _buildIpfsParams();
    _web3client = Web3Client(String.fromEnvironment('rpc_url'), _httpClient);
    _ingesterContractAddress =
        String.fromEnvironment('ingester_contract_address');
    _contractDataGatheringFacet = DataGatheringFacet(
      address: EthereumAddress.fromHex(_ingesterContractAddress),
      client: _web3client,
    );
    _db = sqlite3.open(String.fromEnvironment('sqlite-db'));
  }

  Future<void> run() async {
    try {
      _runDbMigrations();
      await _addAll();
    } on Object {
      rethrow;
    } finally {
      _db.dispose();
      _httpClient.close();
      await _web3client.dispose();
    }
  }

  void _runDbMigrations() {
    _db.execute(SqlChatIpfs.dropIndexUsername);
    _db.execute(SqlChatIpfs.dropTable);
    _db.execute(SqlChatIpfs.createTable);
    _db.execute(SqlChatIpfs.createIndexUsername);

    _db.execute(SqlMessageIpfs.dropIndexDate);
    _db.execute(SqlMessageIpfs.dropIndexChatIdId);
    _db.execute(SqlMessageIpfs.dropTable);
    _db.execute(SqlMessageIpfs.createTable);
    _db.execute(SqlMessageIpfs.createIndexChatIdId);
    _db.execute(SqlMessageIpfs.createIndexDate);
  }

  Future<void> _addAll() async {
    for (final privateKeyIngester in _privateKeysIngesters()) {
      await _add(privateKeyIngester);
    }
  }

  Future<void> _add(String privateKeyIngester) async {
    final credentialsIngester = EthPrivateKey.fromHex(privateKeyIngester);
    final ingesterAddress = credentialsIngester.address;
    final ipfsHashesMeta =
        await _contractDataGatheringFacet.getIpfsHashes(ingesterAddress);
    final ipfsHashMetaChat = ipfsHashesMeta[1];
    final ipfsHashMetaMessages = ipfsHashesMeta[2];
    await _addChats(ipfsHashMetaChat);
    await _addMessages(ipfsHashMetaMessages);
  }

  dynamic _privateKeysIngesters() {
    final privateKeysIngestersFile =
        new io.File(String.fromEnvironment('private_keys_ingesters_file'));
    final privateKeysIngestersJson =
        privateKeysIngestersFile.readAsStringSync();
    return jsonDecode(privateKeysIngestersJson);
  }

  Future<void> _addChats(String ipfsHash) async {
    var ipfsFile = await _ipfsCat(ipfsHash);
    var metas = ipfsFile.split('\n');

    for (var i = 1; i < metas.length; i++) {
      var metaJson = metas[i];
      if (metaJson.isEmpty) continue;
      var meta = jsonDecode(metaJson);
      var dateTimeUploaded = DateTime.parse(meta[2]);
      var dateDiff = _now.difference(dateTimeUploaded).inDays;
      if (dateDiff <= 10) {
        await _insertChats(meta[1]);
      }
    }
  }

  Future<void> _insertChats(String ipfsHash) async {
    var ipfsFile = await _ipfsCat(ipfsHash);
    var datas = ipfsFile.split('\n');

    final stmt = _db.prepare(SqlChatIpfs.insert);

    for (var i = 1; i < datas.length; i++) {
      var dataJson = datas[i];
      if (dataJson.isEmpty) continue;
      var data = jsonDecode(dataJson);
      var params = data.getRange(0, data.length - 1);
      stmt.execute(params.toList());
    }
  }

  Future<void> _addMessages(String ipfsHash) async {
    var ipfsFile = await _ipfsCat(ipfsHash);
    var metas = ipfsFile.split('\n');

    for (var i = 1; i < metas.length; i++) {
      var metaJson = metas[i];
      if (metaJson.isEmpty) continue;
      var meta = jsonDecode(metaJson);
      var dateTimeUploaded = DateTime.parse(meta[2]);
      var dateDiff = _now.difference(dateTimeUploaded).inDays;
      if (dateDiff <= 1) {
        await _insertMessagesFromIpfs(meta[1]);
      }
    }
  }

  Future<void> _insertMessagesFromIpfs(String ipfsHash) async {
    var ipfsFile = await _ipfsCat(ipfsHash);
    var datas = ipfsFile.split('\n');

    final stmt = _db.prepare(SqlMessageIpfs.insert);

    for (var i = 1; i < datas.length; i++) {
      var dataJson = datas[i];
      if (dataJson.isEmpty) continue;
      var data = jsonDecode(dataJson);
      var params = data.getRange(0, data.length - 1);
      stmt.execute(params.toList());
    }
    stmt.dispose();
  }

  Future<String> _ipfsCat(String ipfsHash) async {
    var ipfsUri = _buildIpfsUri(_ipfsParams, '/api/v0/cat/$ipfsHash');
    var request = http.Request('POST', ipfsUri);
    var response =
        await _httpClient.send(request).timeout(const Duration(seconds: 15));
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
