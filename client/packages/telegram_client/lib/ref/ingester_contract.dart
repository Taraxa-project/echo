import 'dart:math';
import 'dart:async';
import 'dart:io' as io;
import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:web3dart/web3dart.dart';
import 'package:web3dart/crypto.dart';
import 'package:http/http.dart';

import 'package:telegram_client/src/smart_contract/DataGatheringFacet.g.dart';

import 'ingester_contract_interface.dart';

class IngesterContract implements IngesterContractInterface {
  final Logger logger;

  final String contractAddress;
  final String contractRpcUrl;
  final int contractMaxGas;
  final String configPath;

  EthPrivateKey? _credentials;

  static const String walletFileName = 'wallet.json';
  static const String walletPrivateKeyName = 'private_key_ingester';

  IngesterContract(
    this.logger,
    this.contractAddress,
    this.contractRpcUrl,
    this.contractMaxGas,
    this.configPath,
    String walletPrivateKey,
  ) {
    _initCredentials(walletPrivateKey);
  }

  @override
  Future<List<String>> getChatsNames() async {
    logger.info('reading Telegram groups...');

    final web3client = Web3Client(contractRpcUrl, Client());
    final contract = DataGatheringFacet(
      address: EthereumAddress.fromHex(contractAddress),
      client: web3client,
    );

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

  void _initCredentials(String walletPrivateKey) {
    final file = new io.File(p.joinAll([configPath, walletFileName]));
    if (file.existsSync()) {
      _credentials = _readCredentialsFromFile(file);
    } else {
      final EthPrivateKey credentials;
      if (walletPrivateKey.isNotEmpty)
        credentials = EthPrivateKey.fromHex(walletPrivateKeyName);
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
    file.writeAsStringSync(jsonEncode(wallet));
  }
}
