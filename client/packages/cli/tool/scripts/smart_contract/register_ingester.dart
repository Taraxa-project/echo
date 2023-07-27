import 'dart:math';

import 'package:web3dart/json_rpc.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:uuid/uuid.dart';

import 'package:telegram_client/src/smart_contract/RegistryFacet.g.dart';

void main() async {
  final credentialsOwner =
      EthPrivateKey.fromHex(String.fromEnvironment('private_key_owner'));
  final credentialsIngester =
      EthPrivateKey.fromHex(String.fromEnvironment('private_key_ingester'));

  final web3client = Web3Client(String.fromEnvironment('rpc_url'), Client());
  final contract = RegistryFacet(
    address: EthereumAddress.fromHex(
        String.fromEnvironment('ingester_contract_address')),
    client: web3client,
  );

  final nonce = BigInt.from(Random().nextInt(100));
  final message = Uuid().v4();

  var messageHash = await contract.hash(
    credentialsIngester.address,
    message,
    nonce,
  );
  var sig = credentialsOwner.signPersonalMessageToUint8List(messageHash);

  var result;
  try {
    result = await contract.registerIngester(
      credentialsIngester.address,
      message,
      nonce,
      sig,
      credentials: credentialsOwner,
      transaction: Transaction(maxGas: 25000000),
    );
  } on RPCError catch (ex) {
    result = ex.toString();
  }

  var ingesterCount = await contract.getIngesterCount();
  var ingesterInfo = await contract.getIngesters();

  print({
    'ingesterCountRemote': ingesterCount,
    'ingesterInfoRemote': ingesterInfo,
    'registerIngesterResult': result,
  });

  await web3client.dispose();
}
