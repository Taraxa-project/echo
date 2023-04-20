import 'package:web3dart/json_rpc.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import 'package:telegram_client/src/smart_contract/IngesterOrchestratorV2.g.dart';

void main() async {
  final credentials =
      EthPrivateKey.fromHex(String.fromEnvironment('private_key'));

  final web3client = Web3Client(String.fromEnvironment('rpc_url'), Client());

  final contractOrchestrator = IngesterOrchestratorV2(
    address: EthereumAddress.fromHex(
        String.fromEnvironment('contract_register_address')),
    client: web3client,
  );

  try {
    var result = contractOrchestrator.addGroup(
      'taraxa_project',
      credentials: credentials,
    );
    print(result);
  } on RPCError catch (ex) {
    print(ex);
  }

  web3client.dispose();
}
