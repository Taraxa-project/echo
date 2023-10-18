import 'dart:io' as io;
import 'dart:convert';

import 'package:path/path.dart' as p;
import 'package:logging/logging.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:sqlite3/sqlite3.dart';

import 'package:telegram_client/src/smart_contract/DataGatheringFacet.g.dart';
import 'package:telegram_client/src/smart_contract/GroupManagerFacet.g.dart';

import 'check_groups_captcha.dart';

Map<String, String> envVars = io.Platform.environment;

void main() async {
  hierarchicalLoggingEnabled = true;
  final obj = AddUploadIds();
  await obj.run();
}

class AddUploadIds {
  final _logger = Logger('Upload');

  final _httpClient = http.Client();
  late final Web3Client _web3client;
  late final _ingesterContractAddress;
  late final DataGatheringFacet _contractDataGatheringFacet;
  late final GroupManagerFacet _contracGroupManagerFacet;
  late final IpfsParams _ipfsParams;
  late final Database _db;

  late final String _workDir;

  static const podNumberMax = 30;
  List<String> _ingesterWallets = [];

  late final DateTime _reportStartDate;
  late final DateTime _reportEndDate;

  AddUploadIds() {
    _logger.onRecord.listen((event) {
      print(event);
    });
    _ipfsParams = _buildIpfsParams();
    _web3client = Web3Client(envVars['rpc_url']!, _httpClient);
    _ingesterContractAddress = envVars['ingester_contract_address']!;
    _contractDataGatheringFacet = DataGatheringFacet(
      address: EthereumAddress.fromHex(_ingesterContractAddress),
      client: _web3client,
    );
    _contracGroupManagerFacet = GroupManagerFacet(
      address: EthereumAddress.fromHex(_ingesterContractAddress),
      client: _web3client,
    );

    _workDir = envVars['work_dir']!;
    final dir = io.Directory(_workDir);
    if (!dir.existsSync()) dir.createSync(recursive: true);

    _db = sqlite3.open(p.join(_workDir, 'db.sqlite'));
  }

  Future<void> run() async {
    try {
      _runDbMigrations();
      _loadIngesterWallets();
      await _process();
    } on Object {
      rethrow;
    } finally {
      _db.dispose();
      _httpClient.close();
      await _web3client.dispose();
    }
  }

  IpfsParams _buildIpfsParams() {
    return IpfsParams(
      envVars['ipfs_scheme']!,
      envVars['ipfs_host']!,
      envVars['ipfs_port']!,
    );
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

  void _runDbMigrations() {
    _logger.info('running migrations...');

    _db.execute(Sql.dropIpfsHashTable);
    _db.execute(Sql.createIpfsHashTable);
  }

  void _loadIngesterWallets() {
    _logger.info('reading k8s secret...');

    final file = new io.File(p.joinAll([workDir, 'echo-secret.json']));
    final fileContent = file.readAsStringSync();
    final secret = jsonDecode(fileContent);

    _ingesterWallets = [];
    for (var podNumber = 0; podNumber <= podNumberMax; podNumber++) {
      _ingesterWallets.add(String.fromCharCodes(
          base64Decode(secret['data']['WALLET_PRIVATE_KEY_$podNumber'])));
    }
  }

  Future<void> _process() async {
    for (var podNumber = 0; podNumber <= podNumberMax; podNumber++) {
      await _processPod(podNumber);
    }
  }

  Future<void> _processPod(int podNumber) async {
    _logger.info('[echo-$podNumber] processing pod $podNumber...');
    final ingesterWallet = EthPrivateKey.fromHex(_ingesterWallets[podNumber]);
    final ingesterAddress = ingesterWallet.address;
    _logger.info('[echo-$podNumber] wallet address is $ingesterAddress...');

    final ipfsHashesMeta =
        await _contractDataGatheringFacet.getIpfsHashes(ingesterAddress);
    final ipfsHashMetaMessages = ipfsHashesMeta[2];

    _logger
        .info('[echo-$podNumber] message meta file $ipfsHashMetaMessages...');

    final ipfsHashesMetaContent = await _ipfsCat(ipfsHashMetaMessages);
    final ipfsHashesData = ipfsHashesMetaContent
        .split('\n')
        .where((element) => element.isNotEmpty)
        .toList();

    _logger.info(
        '[echo-$podNumber] found ${ipfsHashesData.length - 1} data hashes...');

    for (var i = 1; i < ipfsHashesData.length; i++) {
      final ipfsHashData = ipfsHashesData[i];
      await _processPodIpfsData(podNumber, ipfsHashData, ingesterAddress);
    }
  }

  Future<void> _processPodIpfsData(int podNumber, String ipfsHashData,
      EthereumAddress ingesterAddress) async {
    final ipfsHashInfo = jsonDecode(ipfsHashData);
    print(ipfsHashInfo);
    final ipfsHash = ipfsHashInfo[0];
    _logger.info('[echo-$podNumber] processing data file ${ipfsHash}...');

    final messagesContent = await _ipfsCat(ipfsHash);
    final messagesInfo = messagesContent
        .split('\n')
        .where((element) => element.isNotEmpty)
        .toList();

    _logger.info(
        '[echo-$podNumber] found ${messagesInfo.length - 1} messages ...');
    if (messagesInfo.length > 1) {
      var messageInfoFirst = jsonDecode(messagesInfo[1]);
      var rowIdMin = messageInfoFirst[messageInfoFirst.length - 1];
      var messageInfoLast = jsonDecode(messagesInfo[messagesInfo.length - 1]);
      var rowIdMax = messageInfoLast[messageInfoLast.length - 1];

      final params = [
        'message',
        ipfsHash,
        ipfsHashInfo[1],
        ipfsHashInfo[2],
        ipfsHashInfo[5],
        rowIdMin,
        rowIdMax,
        ingesterAddress.toString(),
        podNumber
      ];
      _db.execute(Sql.insert, params);
    }
  }

  Future<void> _collectChats() async {
    _logger.info('collecting chats...');

    final groupCountBigInt = await _contracGroupManagerFacet.getGroupCount();
    final groupCount = groupCountBigInt.toInt();
    _logger.info('found $groupCount chats...');

    final stmt = _db.prepare(SqlChat.insert);

    for (var groupIndex = 0; groupIndex < groupCount; groupIndex++) {
      final groupIndexBigInt = BigInt.from(groupIndex);
      final groupUsername = await _contracGroupManagerFacet
          .getGroupUsernameByIndex(groupIndexBigInt);
      final params = [groupUsername];
      stmt.execute(params);
    }

    stmt.dispose();
  }

  Future<void> _collectDataForIngesters() async {
    final ingestersAddresses = await _contractDataGatheringFacet.getIngesters();
    _logger.info('processing ${ingestersAddresses.length} ingesters...');
    for (final ingesterAddress in ingestersAddresses) {
      await _collectDataForIngester(ingesterAddress);
    }
  }

  Future<void> _collectDataForIngester(EthereumAddress ingesterAddress) async {
    _logger.info('collecting data for ingester $ingesterAddress...');

    final ipfsHashesMeta =
        await _contractDataGatheringFacet.getIpfsHashes(ingesterAddress);
    final ipfsHashMetaChat = ipfsHashesMeta[1];
    final ipfsHashMetaMessages = ipfsHashesMeta[2];

    await _collectChatsForIngester(ingesterAddress, ipfsHashMetaChat);
    await _collectMessagesForIngester(ingesterAddress, ipfsHashMetaMessages);
    await _collectChatsReadForIngester(ingesterAddress);
  }

  Future<void> _collectChatsForIngester(
      EthereumAddress ingesterAddress, String ipfsHash) async {
    _logger.info('chat hash meta: $ipfsHash');

    var ipfsFile = await _ipfsCat(ipfsHash);
    var metas = ipfsFile.split('\n');

    for (var i = metas.length - 1; i > 1; i--) {
      var metaJson = metas[i];
      if (metaJson.isEmpty) continue;
      var meta = jsonDecode(metaJson);

      var dataHash = meta[1];
      var dateTimeUploaded = DateTime.parse(meta[2]);

      var dateDiff = dateTimeUploaded.difference(_reportStartDate).inDays;
      if (dateDiff >= 0) {
        _logger.info('chat hash data from $dateTimeUploaded: $dataHash');
        await _insertChatsForIngeser(ingesterAddress, dataHash);
      }
    }
  }

  Future<void> _insertChatsForIngeser(
      EthereumAddress ingesterAddress, String ipfsHash) async {
    var ipfsFile = await _ipfsCat(ipfsHash);
    var datas = ipfsFile.split('\n');

    final stmt = _db.prepare(SqlChatIngester.insert);

    for (var i = 1; i < datas.length; i++) {
      var dataJson = datas[i];
      if (dataJson.isEmpty) continue;
      var data = jsonDecode(dataJson);
      List<dynamic> params = data.getRange(0, data.length - 1).toList();
      if (params.length == 10) params.add(null);
      params.add(ingesterAddress.hex);
      stmt.execute(params);
    }
  }

  Future<void> _collectMessagesForIngester(
      EthereumAddress ingesterAddress, String ipfsHash) async {
    _logger.info('message hash meta: $ipfsHash');

    var ipfsFile = await _ipfsCat(ipfsHash);
    var metas = ipfsFile.split('\n');

    for (var i = 1; i < metas.length; i++) {
      var metaJson = metas[i];
      if (metaJson.isEmpty) continue;
      var meta = jsonDecode(metaJson);

      var dataHash = meta[1];
      var dateTimeUploaded = DateTime.parse(meta[2]);

      var dateDiff = dateTimeUploaded.difference(_reportStartDate).inDays;
      if (dateDiff >= 0) {
        _logger.info('message hash data from $dateTimeUploaded: $dataHash');
        await _insertMessagesForIngester(ingesterAddress, meta[1]);
      }
    }
  }

  Future<void> _insertMessagesForIngester(
      EthereumAddress ingesterAddress, String ipfsHash) async {
    var ipfsFile = await _ipfsCat(ipfsHash);
    var datas = ipfsFile.split('\n');

    final stmt = _db.prepare(SqlMessageIngester.insert);

    for (var i = 1; i < datas.length; i++) {
      var dataJson = datas[i];
      if (dataJson.isEmpty) continue;
      var data = jsonDecode(dataJson);
      var params = data.getRange(0, data.length - 1).toList();
      params.add(ingesterAddress.hex);
      stmt.execute(params);
    }
    stmt.dispose();
  }

  Future<void> _collectChatsReadForIngester(
      EthereumAddress ingesterAddress) async {
    final chats = await _db
        .select(SqlChatIngester.selectAllForIngester, [ingesterAddress.hex]);
    for (final chat in chats) {
      final ipfsHash = chat['file_hash_chat_read'];
      if (ipfsHash == null) continue;
      _logger.info('chat read hash data from : $ipfsHash');
      await _insertChatReadForIngester(ingesterAddress, ipfsHash);
    }
  }

  Future<void> _insertChatReadForIngester(
      EthereumAddress ingesterAddress, String ipfsHash) async {
    var ipfsFile = await _ipfsCat(ipfsHash);
    var datas = ipfsFile.split('\n');

    final stmt = _db.prepare(SqlChatReadIngester.insert);

    for (var i = 1; i < datas.length; i++) {
      var dataJson = datas[i];
      if (dataJson.isEmpty) continue;
      var data = jsonDecode(dataJson);
      var params = data.getRange(1, data.length - 1).toList();
      params.add(ingesterAddress.hex);
      stmt.execute(params);
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

  Future<void> _runReportChatCover() async {
    _db.execute(SqlReportChatCover.dropIndexUsername);
    _db.execute(SqlReportChatCover.dropIndexId);
    _db.execute(SqlReportChatCover.dropTable);
    _db.execute(SqlReportChatCover.createTable);
    _db.execute(SqlReportChatCover.createIndexUsername);
    _db.execute(SqlReportChatCover.createIndexId);

    final params = [
      _reportStartDate.toIso8601String(),
      _reportEndDate.toIso8601String()
    ];

    _db.execute(SqlReportChatCover.insertUpdated, params);
    _db.execute(SqlReportChatCover.updateMessageCount, params);
    _db.execute(SqlReportChatCover.updateUserCount, params);
    _db.execute(SqlReportChatCover.insertNotUpdate);
    _db.execute(SqlReportChatCover.updateBlacklisted);

    final stmt = _db.prepare(SqlReportChatCover.report);
    final cursor = stmt.selectCursor();

    final fileName = 'chat-cover-${_reportStartDate.toIso8601String()}.csv';
    final fileNameFullPath = p.join(_workDir, fileName);

    await _writeReportFromCursor(fileNameFullPath, cursor);

    stmt.dispose();
  }

  Future<void> _writeReportFromCursor(
      String fileNameFullPath, IteratingCursor cursor) async {
    final file = new io.File(fileNameFullPath);
    file.createSync();

    final sink = file.openWrite(mode: io.FileMode.write);

    var rowCount = 0;

    try {
      sink.write(cursor.columnNames.join('\t') + '\n');

      final flushCount = 100;
      while (cursor.moveNext()) {
        var fileRow = cursor.current.values.join('\t');
        sink.write(fileRow + '\n');
        rowCount++;
        if (rowCount % flushCount == 0) await sink.flush();
      }
    } on Object {
      rethrow;
    } finally {
      await sink.flush();
      await sink.close();
    }
  }

  Future<void> _runReportChatActivity() async {
    final params = [
      _reportStartDate.toIso8601String(),
      _reportEndDate.toIso8601String()
    ];

    final stmt = _db.prepare(SqlReportChatActivity.report);
    final cursor = stmt.selectCursor(params);

    final fileName = 'chat-activity-${_reportStartDate.toIso8601String()}.csv';
    final fileNameFullPath = p.join(_workDir, fileName);

    await _writeReportFromCursor(fileNameFullPath, cursor);

    stmt.dispose();
  }

  Future<void> _runReportChatKeepUp() async {
    final params = [
      _reportStartDate.toIso8601String(),
      _reportEndDate.toIso8601String()
    ];

    final stmt = _db.prepare(Sql.report);
    final cursor = stmt.selectCursor(params);

    final fileName = 'chat-keep-up-${_reportStartDate.toIso8601String()}.csv';
    final fileNameFullPath = p.join(_workDir, fileName);

    await _writeReportFromCursor(fileNameFullPath, cursor);

    stmt.dispose();
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

class SqlChat {
  static const dropIndexUsername = '''
DROP INDEX IF EXISTS idx_chat_username;
''';

  static const dropTable = '''
DROP TABLE IF EXISTS chat;
''';

  static const createTable = '''
CREATE TABLE IF NOT EXISTS chat (
  username TEXT UNIQUE ON CONFLICT IGNORE NOT NULL
);
''';

  static const createIndexUsername = '''
CREATE UNIQUE INDEX IF NOT EXISTS idx_chat_username
ON chat (username);
''';

  static const insert = '''
INSERT INTO
  chat (
    username)
VALUES (
    ?)
ON CONFLICT DO NOTHING;
''';
}

class SqlChatIngester {
  static const dropIndexUsername = '''
DROP INDEX IF EXISTS idx_chat_ingester_username_ingester_address;
''';

  static const dropTable = '''
DROP TABLE IF EXISTS chat_ingester;
''';

  static const createTable = '''
CREATE TABLE IF NOT EXISTS chat_ingester (
  username TEXT,
  id INTEGER,
  title TEXT,
  member_count INTEGER, 
  member_online_count INTEGER,
  bot_count INTEGER,
  blacklisted INTEGER DEFAULT 0, /* 0 - false; 1 - true; */
  blacklist_reason TEXT,
  created_at TEXT,
  updated_at TEXT,
  file_hash_chat_read TEXT,
  ingester_address TEXT
);
''';

  static const createIndexUsername = '''
CREATE UNIQUE INDEX IF NOT EXISTS idx_chat_ingester_username_ingester_address
ON chat_ingester (username, ingester_address);
''';

  static const insert = '''
INSERT INTO
  chat_ingester (
    username, id, title,
    member_count, member_online_count, bot_count,
    blacklisted, blacklist_reason,
    created_at, updated_at, file_hash_chat_read, ingester_address)
VALUES (
    ?, ?, ?,
    ?, ?, ?,
    ?, ?,
    ?, ?, ?, ?)
ON CONFLICT DO NOTHING;
''';

  static const selectAllForIngester = '''
SELECT
  *
FROM
  chat_ingester
WHERE
  ingester_address = ?
''';
}

class SqlMessageIngester {
  static const dropIndexChatIdId = '''
DROP INDEX IF EXISTS idx_message_ingester_chat_id_id_ingester_address;
''';
  static const dropIndexDate = '''
DROP INDEX IF EXISTS idx_message_ingester_date;
''';

  static const dropTable = '''
DROP TABLE IF EXISTS message_ingester;
''';

  static const createTable = '''
CREATE TABLE IF NOT EXISTS message_ingester (
  chat_id INTEGER NOT NULL,
  id INTEGER NOT NULL,
  date TEXT,
  sender_id INTEGER,
  sender_type TEXT,
  text TEXT,
  member_online_count INTEGER,
  views INTEGER,
  replies INTEGER,
  forwards INTEGER,
  reply_to_id INTEGER,
  created_at TEXT,
  updated_at TEXT,
  ingester_address TEXT
);
''';

  static const createIndexChatIdId = '''
CREATE UNIQUE INDEX IF NOT EXISTS idx_message_ingester_chat_id_id_ingester_address
ON message_ingester (chat_id, id, ingester_address);
''';

  static const createIndexDate = '''
CREATE INDEX IF NOT EXISTS idx_message_ingester_date
ON message_ingester (date);
''';

  static const insert = '''INSERT INTO message_ingester (
  chat_id, id, date, sender_id, sender_type, text, 
  member_online_count, views, replies, forwards, reply_to_id, 
  created_at, updated_at, ingester_address
)
VALUES (
  ?, ?, ?, ?, ?, ?,
  ?, ?, ?, ?, ?,
  ?, ?, ?
) ON CONFLICT DO NOTHING;
''';
}

class SqlReportChatCover {
  static const dropIndexUsername = '''
DROP INDEX IF EXISTS idx_chat_cover_username_ingester_address;
''';
  static const dropIndexId = '''
DROP INDEX IF EXISTS idx_chat_cover_id_ingester_address;
''';

  static const dropTable = '''
DROP TABLE IF EXISTS chat_cover;
''';

  static const createTable = '''
CREATE TABLE IF NOT EXISTS chat_cover (
  username TEXT UNIQUE ON CONFLICT IGNORE NOT NULL,
  id INTEGER,
  title TEXT,
  message_count INTEGER,
  user_count INTEGER,
  blacklisted INTEGER,
  ingester_address TEXT
);
''';

  static const createIndexUsername = '''
CREATE INDEX IF NOT EXISTS idx_chat_cover_username_ingester_address
ON chat_cover (username, ingester_address);
''';

  static const createIndexId = '''
CREATE INDEX IF NOT EXISTS idx_chat_cover_id_ingester_address
ON chat_cover (id, ingester_address);
''';

  static const insertUpdated = '''
INSERT INTO chat_cover
  (username, ingester_address, id, title)
SELECT
  username, ingester_address, id, title
FROM
  chat_ingester
WHERE
  updated_at >= ? AND updated_at < ?;
''';

  static const updateMessageCount = '''
UPDATE chat_cover 
SET message_count = b.count
FROM (
  SELECT
    chat_id,
    ingester_address,
    count(1) count
  FROM
    message_ingester
  WHERE
    "date" >= ? and "date" < ?
  GROUP BY
    chat_id, ingester_address
) b
WHERE
  chat_cover.id = b.chat_id AND
  chat_cover.ingester_address = b.ingester_address;
''';

  static const updateUserCount = '''
UPDATE chat_cover 
SET user_count = b.count
FROM (
  SELECT
    chat_id,
    ingester_address,
    count(distinct sender_id) count
  FROM
    message_ingester
  WHERE
    "date" >= ? AND "date" < ?
  GROUP BY
    chat_id, ingester_address
) b
WHERE
  chat_cover.id = b.chat_id AND
  chat_cover.ingester_address = b.ingester_address;
''';

  static const insertNotUpdate = '''
INSERT INTO chat_cover (username)
SELECT a.username FROM chat a
LEFT JOIN chat_cover b ON a.username = b.username
WHERE
  b.username IS null;
''';

  static const updateBlacklisted = '''
UPDATE chat_cover
SET blacklisted = a.blacklisted
FROM (
  SELECT
    username,
    blacklisted
  FROM
    chat_ingester
  WHERE
    blacklisted = 1
) a 
WHERE
  chat_cover.username = a.username AND
  chat_cover.ingester_address IS null;''';

  static const report = '''
SELECT
  id "Chat ID", 
  username "Chat Name",
  title "Chat Title",
  blacklisted "Blacklisted?",
  user_count "Users",
  message_count "Messages",
  ingester_address "Ingester Address"
FROM
  chat_cover;
''';
}

class SqlReportChatActivity {
  static const report = '''
SELECT
  a.chat_id, b.username, b.title, max(a.count) count
FROM (
SELECT
  chat_id, ingester_address, count(1) count
FROM
  message_ingester
WHERE
  "date" >= ? and "date" < ?
GROUP BY chat_id, ingester_address
) a
INNER JOIN chat_ingester b on a.chat_id = b.id
GROUP BY a.chat_id
ORDER BY count DESC;
''';
}

class SqlChatReadIngester {
  static const dropIndexChatId = '''
DROP INDEX IF EXISTS idx_chat_read_ingester_chat_id;
''';

  static const dropIndexStartedAt = '''
DROP INDEX IF EXISTS idx_chat_read_ingester_started_at;
''';

  static const dropIndexFinishedAt = '''
DROP INDEX IF EXISTS idx_chat_read_ingester_finished_at;
''';

  static const dropTable = '''
DROP TABLE IF EXISTS chat_read_ingester;
''';

  static const createTable = '''
CREATE TABLE IF NOT EXISTS chat_read_ingester (
  chat_id INTEGER NOT NULL,
  message_count INTEGER,
  started_at TEXT,
  finished_at TEXT,
  ingester_address TEXT
);
''';

  static const createIndexChatId = '''
CREATE INDEX IF NOT EXISTS idx_chat_read_ingester_chat_id ON
  chat_read_ingester (chat_id, ingester_address);
''';

  static const createIndexStartedAt = '''
CREATE INDEX IF NOT EXISTS idx_chat_read_ingester_started_at ON
  chat_read_ingester (started_at);
''';

  static const createIndexFinishedAt = '''
CREATE INDEX IF NOT EXISTS idx_chat_read_ingester_finished_at ON
  chat_read_ingester (finished_at);
''';

  static const insert = '''
INSERT INTO chat_read_ingester (
  chat_id,
  message_count,
  started_at,
  finished_at,
  ingester_address
) VALUES (
  ?, ?, ?, ?, ?
);
''';
}

class Sql {
  static const report = '''
SELECT
	b.id "Chat ID",
	b.username "Chat Name",
	b.title "Chat Title",
	a.started_at "Start Timestamp",
	a.finished_at "Finish Timestamp",
	a.message_count "Messages",
	a.ingester_address "Ingester Address"
FROM
	chat_read_ingester a
	INNER JOIN chat_ingester b ON a.chat_id = b.id AND a.ingester_address = b.ingester_address
WHERE
	a.started_at >= ? AND
	a.started_at < ?
ORDER BY
	a.started_at ASC;
''';

  static const dropIpfsHashTable = '''
DROP TABLE IF EXISTS ipfs_hash;
''';

  static const createIpfsHashTable = '''
CREATE TABLE IF NOT EXISTS ipfs_hash (
  table_name TEXT,
  file_hash TEXT,
  created_at TEXT,
  updated_at TEXT,
  ext_rowid INTEGER,
  id_min INTEGER,
  id_max INTEGER,
  ingester_address TEXT,
  pod INTEGER
);
''';

  static const insert = '''
INSERT INTO ipfs_hash
  (table_name, file_hash, created_at, updated_at, ext_rowid, id_min, id_max, ingester_address, pod)
VALUES
  (?, ?, ?, ?, ?, ?, ?, ?, ?);
''';
}
