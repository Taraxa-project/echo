import 'dart:io' as io;

import 'package:web3dart/json_rpc.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import 'package:telegram_client/src/smart_contract/GroupManagerFacet.g.dart';

void main() async {
  final credentials =
      EthPrivateKey.fromHex(String.fromEnvironment('private_key'));

  final web3client = Web3Client(String.fromEnvironment('rpc_url'), Client());
  final contract = GroupManagerFacet(
    address: EthereumAddress.fromHex(
        String.fromEnvironment('ingester_contract_address')),
    client: web3client,
  );

  final file = new io.File(String.fromEnvironment('file_telegram_groups'));
  final groups = file.readAsLinesSync();

  for (var groupIndex = 0; groupIndex < groups.length; groupIndex++) {
    final groupName = groups[groupIndex].trim();
    var result;
    try {
      result = await contract.addGroup(
        groupName,
        credentials: credentials,
        transaction: Transaction(maxGas: 25000000),
      );
    } on RPCError catch (ex) {
      result = ex.toString();
    }

    await Future.delayed(const Duration(seconds: 20));

    var groupCountRemote = (await contract.getGroupCount()).toInt();
    print({
      'localIndex': groupIndex,
      'groupName': groupName,
      'groupCountRemote': groupCountRemote,
      'addGroupResult': result,
    });
  }

  await web3client.dispose();
}
