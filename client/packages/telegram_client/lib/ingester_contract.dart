import 'dart:math';
import 'dart:async';
import 'dart:io' as io;
import 'dart:convert';
import 'dart:isolate';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:web3dart/web3dart.dart';
import 'package:web3dart/json_rpc.dart';
import 'package:web3dart/crypto.dart';
import 'package:http/http.dart';

import 'isolate.dart';
import 'db.dart';
import 'package:telegram_client/src/smart_contract/IngesterProxy.g.dart';

class IngesterContractIsolater extends Isolater {
  final logger = Logger('TelegramClient');

  Future<IngesterContractMsgResponseGetGroups> getGroups() async {
    sendPort!.send(IngesterContractMsgRequestGetGroups(
      replySendPort: receivePort.sendPort,
    ));
    IngesterContractMsgResponseGetGroups response = await receivePortBroadcast
        .firstWhere(
            (element) => element is IngesterContractMsgResponseGetGroups)
        .onError(<StateError>(error, _) =>
            logger.warning('ingester get groups $error'));

    if (response.exception != null) {
      throw response.exception!;
    }
    return response;
  }
}

class IngesterContract extends Isolated {
  SendPort? logSendPort;

  final SendPort dbSendPort;

  final String contractRpcUrl;
  final String contractAddress;

  EthPrivateKey? _credentialsIngester;

  String configPath;
  static const String configFileName = 'config.json';

  IngesterContract({
    Level? super.logLevel,
    SendPort? this.logSendPort,
    required SendPort this.dbSendPort,
    required String this.contractAddress,
    required String this.contractRpcUrl,
    required String this.configPath,
  }) {
    logger.onRecord.listen((logRecord) {
      logSendPort?.send(logRecord);
    });
  }

  Future<void> init(SendPort parentSendPort) async {
    super.init(parentSendPort);
    _initCredentialsIngester();
  }

  Future<void> initDispatch() async {
    receivePortBroadcast.listen((message) async {
      if (message is IsolateMsgRequestExit) {
        logger.fine('exiting...');
        exit(message.replySendPort);
      } else if (message is IngesterContractMsgRequestGetGroups) {
        await _getGroups(message.replySendPort);
      } else if (message is IngesterContractMsgRequestWriteHashes) {
        await _writeHashes(message.replySendPort);
      }
    });
  }

  void _initCredentialsIngester() {
    final file = new io.File(p.joinAll([configPath, configFileName]));

    var config;

    if (file.existsSync()) {
      try {
        config = jsonDecode(file.readAsStringSync());
      } on FormatException catch (ex) {
        logger.severe(ex);
        rethrow;
      }

      if (config is! Map) {
        throw FormatException('Invalid config format');
      }
      if (!config.containsKey('private_key_ingester')) {
        throw FormatException('Missing private_key_ingester from config');
      }

      _credentialsIngester =
          EthPrivateKey.fromHex(config['private_key_ingester']);
    } else {
      var credentials = EthPrivateKey.createRandom(Random.secure());
      config = {
        'private_key_ingester': bytesToHex(
          credentials.privateKey,
          include0x: true,
        )
      };

      try {
        file.writeAsStringSync(jsonEncode(config));
      } on Exception catch (ex) {
        logger.severe(ex);
        rethrow;
      }

      _credentialsIngester = credentials;
    }
  }

  Future<void> _getGroups(SendPort? replySendPort) async {
    final web3client = Web3Client(contractRpcUrl, Client());
    final contract = IngesterProxy(
      address: EthereumAddress.fromHex(contractAddress),
      client: web3client,
    );
    var response = IngesterContractMsgResponseGetGroups();

    var ingesterInfo;
    try {
      ingesterInfo =
          await contract.getIngesterWithGroups(_credentialsIngester!.address);
      response.groups = ingesterInfo[3].cast<String>();
    } on RPCError catch (ex) {
      logger.severe(ex);
      response.exception = ex;
    } finally {
      replySendPort?.send(response);
      await web3client.dispose();
    }
  }

  Future<void> _writeHashes(SendPort? replySendPort) async {
    dbSendPort
        .send(DbMsgRequestGetUploadHashes(replySendPort: receivePort.sendPort));
    var responseGetUploadedHashes = await receivePortBroadcast
        .where((event) => event is DbMsgResponseGetUploadHashes)
        .first as DbMsgResponseGetUploadHashes;
    if (responseGetUploadedHashes.exception != null) {
      logger.severe(responseGetUploadedHashes.exception!);
      return;
    }
    if (responseGetUploadedHashes.chat_hash == null ||
        responseGetUploadedHashes.message_hash == null ||
        responseGetUploadedHashes.user_hash == null) {
      return;
    }

    final web3client = Web3Client(contractRpcUrl, Client());
    final contract = IngesterProxy(
      address: EthereumAddress.fromHex(contractAddress),
      client: web3client,
    );

    var response = IngesterContractMsgResponseWriteHashes();
    try {
      await contract.addIpfsHash(
        responseGetUploadedHashes.user_hash!,
        responseGetUploadedHashes.chat_hash!,
        responseGetUploadedHashes.message_hash!,
        credentials: _credentialsIngester!,
      );
    } on RPCError catch (ex) {
      logger.severe(ex);
      response.exception = ex;
    } finally {
      replySendPort?.send(response);
      await web3client.dispose();
    }
  }
}

class IngesterContractMsgRequest extends IsolateMsgRequest {
  IngesterContractMsgRequest({super.replySendPort});
}

class IngesterContractMsgResponse extends IsolateMsgResponse {
  Exception? exception;
  IngesterContractMsgResponse({this.exception});
}

class IngesterContractMsgRequestGetGroups extends IngesterContractMsgRequest {
  IngesterContractMsgRequestGetGroups({super.replySendPort});
}

class IngesterContractMsgResponseGetGroups extends IngesterContractMsgResponse {
  List<String>? groups;
  IngesterContractMsgResponseGetGroups({super.exception, this.groups});
}

class IngesterContractMsgRequestWriteHashes extends IngesterContractMsgRequest {
  IngesterContractMsgRequestWriteHashes({super.replySendPort});
}

class IngesterContractMsgResponseWriteHashes
    extends IngesterContractMsgResponse {
  IngesterContractMsgResponseWriteHashes({super.exception});
}
