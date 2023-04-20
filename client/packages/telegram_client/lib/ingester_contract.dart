import 'dart:math';
import 'dart:async';
import 'dart:io' as io;
import 'dart:convert';
import 'dart:isolate';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:telegram_client/src/smart_contract/IngesterDataGatheringV2.g.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3dart/json_rpc.dart';
import 'package:web3dart/crypto.dart';
import 'package:http/http.dart';
import 'package:uuid/uuid.dart';

import 'isolate.dart';
import 'db.dart';
import 'package:telegram_client/src/smart_contract/IngesterRegistrationV2.g.dart';

class IngesterContract extends Isolated {
  SendPort? logSendPort;

  final SendPort dbSendPort;

  final String contractRpcUrl;
  final String contractAddress;

  final String ownerPrivateKey;
  EthPrivateKey? _credentialsOwner;
  EthPrivateKey? _credentialsIngester;

  String configPath;
  static const String configFileName = 'config.json';

  IngesterContract({
    Level? super.logLevel,
    SendPort? this.logSendPort,
    required SendPort this.dbSendPort,
    required String this.contractAddress,
    required String this.contractRpcUrl,
    required String this.ownerPrivateKey,
    required String this.configPath,
  }) {
    logger.onRecord.listen((logRecord) {
      logSendPort?.send(logRecord);
    });
  }

  Future<void> init(SendPort parentSendPort) async {
    super.init(parentSendPort);
    _initCredentialsOwner();
    _initCredentialsIngester();
  }

  Future<void> initDispatch() async {
    receivePortBroadcast.listen((message) async {
      if (message is IsolateMsgRequestExit) {
        logger.fine('exiting...');
        exit(message.replySendPort);
      } else if (message is IngesterContractMsgRequestRegister) {
        await _register(message.replySendPort);
      } else if (message is IngesterContractMsgRequestGetGroups) {
        await _getGroups(message.replySendPort);
      } else if (message is IngesterContractMsgRequestWriteHashes) {
        await _writeHashes(message.replySendPort);
      }
    });
  }

  void _initCredentialsOwner() {
    _credentialsOwner = EthPrivateKey.fromHex(ownerPrivateKey);
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
      config = {'private_key_ingester': bytesToHex(credentials.privateKey)};

      try {
        file.writeAsStringSync(jsonEncode(config));
      } on Exception catch (ex) {
        logger.severe(ex);
        rethrow;
      }

      _credentialsIngester = credentials;
    }
  }

  Future<void> _register(SendPort? replySendPort) async {
    final web3client = Web3Client(contractRpcUrl, Client());
    final contractRegister = IngesterRegistrationV2(
      address: EthereumAddress.fromHex(contractAddress),
      client: web3client,
    );
    final nonce = BigInt.from(Random().nextInt(100));
    final message = Uuid().v4();

    try {
      var messageHash = await contractRegister.hash(
        _credentialsOwner!.address,
        message,
        nonce,
      );
      var sig = _credentialsOwner!.signPersonalMessageToUint8List(messageHash);

      var result = await contractRegister.registerIngester(
        _credentialsOwner!.address,
        // _credentialsIngester!.address,
        message,
        nonce,
        sig,
        credentials: _credentialsOwner!,
      );
      print(result);
    } on RPCError catch (ex) {
      if (!ex.message.contains('already registered')) {
        logger.severe(ex);
        rethrow;
      }
    } finally {
      replySendPort?.send(IngesterContractMsgResponseRegister());
      await web3client.dispose();
    }
  }

  Future<void> _getGroups(SendPort? replySendPort) async {
    final web3client = Web3Client(contractRpcUrl, Client());
    final contractRegister = IngesterRegistrationV2(
      address: EthereumAddress.fromHex(contractAddress),
      client: web3client,
    );
    var ingesterInfo;
    try {
      ingesterInfo =
          await contractRegister.getIngester(_credentialsOwner!.address);
    } on RPCError catch (ex) {
      logger.severe(ex);
      rethrow;
    } finally {
      replySendPort?.send(IngesterContractMsgResponseGetGroups(
        groups: ingesterInfo[2],
      ));
      web3client.dispose();
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
    final contractRegister = IngesterDataGatheringV2(
      address: EthereumAddress.fromHex(contractAddress),
      client: web3client,
    );

    try {
      await contractRegister.addIpfsHash(
        _credentialsOwner!.address,
        responseGetUploadedHashes.user_hash!,
        responseGetUploadedHashes.chat_hash!,
        responseGetUploadedHashes.message_hash!,
        credentials: _credentialsOwner!,
      );
    } on RPCError catch (ex) {
      logger.severe(ex);
      rethrow;
    } finally {
      replySendPort?.send(IngesterContractMsgResponseWriteHashes());
      web3client.dispose();
    }
  }
}

class IngesterContractMsgRequest extends IsolateMsgRequest {
  IngesterContractMsgRequest({super.replySendPort});
}

class IngesterContractMsgResponse extends IsolateMsgResponse {}

class IngesterContractMsgRequestRegister extends IngesterContractMsgRequest {
  IngesterContractMsgRequestRegister({super.replySendPort});
}

class IngesterContractMsgResponseRegister extends IngesterContractMsgResponse {}

class IngesterContractMsgRequestGetGroups extends IngesterContractMsgRequest {
  IngesterContractMsgRequestGetGroups({super.replySendPort});
}

class IngesterContractMsgResponseGetGroups extends IngesterContractMsgResponse {
  final List<String> groups;
  IngesterContractMsgResponseGetGroups({required this.groups});
}

class IngesterContractMsgRequestWriteHashes extends IngesterContractMsgRequest {
  IngesterContractMsgRequestWriteHashes({super.replySendPort});
}

class IngesterContractMsgResponseWriteHashes
    extends IngesterContractMsgResponse {}
