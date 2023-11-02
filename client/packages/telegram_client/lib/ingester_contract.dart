import 'dart:math';
import 'dart:async';
import 'dart:io' as io;
import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:web3dart/web3dart.dart';
import 'package:web3dart/crypto.dart';
import 'package:http/http.dart';

import 'src/smart_contract/GroupManagerFacet.g.dart';
import 'src/smart_contract/DataGatheringFacet.g.dart';

class IngesterContract {
  final Logger logger;
  final IngesterContractParams ingesterContractParams;

  EthPrivateKey? _credentials;

  static const String walletFileName = 'wallet.json';
  static const String walletPrivateKeyName = 'private_key_ingester';

  IngesterContract(this.logger, this.ingesterContractParams) {
    _initCredentials(ingesterContractParams.walletPrivateKey);
  }

  Future<List<String>> getChatsNames() async {
    logger.info('reading Telegram groups...');

    final web3client =
        Web3Client(ingesterContractParams.contractRpcUrl, Client());
    final contract = GroupManagerFacet(
        address:
            EthereumAddress.fromHex(ingesterContractParams.contractAddress),
        client: web3client);

    try {
      final ingesterWithGroups =
          await contract.getIngesterWithGroups(_credentials!.address);
      final List<String> chatsNames = ingesterWithGroups[3].cast<String>();
      logger.info('received ${chatsNames.length} Telegram groups.');
      return chatsNames;
    } on Object {
      rethrow;
    } finally {
      await web3client.dispose();
    }
  }

  Future<void> writeHashes(
      String chatHash, String messageHash, String userHash) async {
    logger.info('writing hashes in smart contract...');
    logger.info('chat $chatHash');
    logger.info('message $messageHash');
    logger.info('user $userHash');

    final web3client =
        Web3Client(ingesterContractParams.contractRpcUrl, Client());
    final contract = DataGatheringFacet(
        address:
            EthereumAddress.fromHex(ingesterContractParams.contractAddress),
        client: web3client);

    try {
      await contract.addIpfsHash(userHash, chatHash, messageHash,
          credentials: _credentials!,
          transaction:
              Transaction(maxGas: ingesterContractParams.contractMaxGas));
    } on Object {
      rethrow;
    } finally {
      await web3client.dispose();
    }
  }

  void _initCredentials(String walletPrivateKey) {
    final file = new io.File(
        p.joinAll([ingesterContractParams.configPath, walletFileName]));
    if (file.existsSync()) {
      _credentials = _readCredentialsFromFile(file);
    } else {
      final EthPrivateKey credentials;
      if (walletPrivateKey.isNotEmpty)
        credentials = EthPrivateKey.fromHex(walletPrivateKey);
      else
        credentials = EthPrivateKey.createRandom(Random.secure());
      _writeCredentialsToFile(file, credentials);
      _credentials = credentials;
    }
  }

  EthPrivateKey _readCredentialsFromFile(io.File file) {
    final wallet = jsonDecode(file.readAsStringSync());
    if (wallet is! Map)
      throw FormatException('$walletFileName has invalid format');
    if (!wallet.containsKey(walletPrivateKeyName))
      throw FormatException('$walletFileName is missing $walletPrivateKeyName');
    return EthPrivateKey.fromHex(wallet[walletPrivateKeyName]);
  }

  void _writeCredentialsToFile(io.File file, EthPrivateKey credentials) {
    final wallet = {
      walletPrivateKeyName: bytesToHex(
        credentials.privateKey,
        include0x: true,
      )
    };
    file.writeAsStringSync(jsonEncode(wallet), flush: true);
  }
}

class IngesterContractParams {
  final String contractAddress;
  final String contractRpcUrl;
  final int contractMaxGas;
  final String configPath;
  final String walletPrivateKey;

  IngesterContractParams(
    this.contractAddress,
    this.contractRpcUrl,
    this.contractMaxGas,
    this.configPath,
    this.walletPrivateKey,
  );
}
