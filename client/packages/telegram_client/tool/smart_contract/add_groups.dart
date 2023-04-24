import 'package:web3dart/json_rpc.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import 'package:telegram_client/src/smart_contract/IngesterProxy.g.dart';

void main() async {
  final credentials =
      EthPrivateKey.fromHex(String.fromEnvironment('private_key'));

  final web3client = Web3Client(String.fromEnvironment('rpc_url'), Client());

  final contractOrchestrator = IngesterProxy(
    address: EthereumAddress.fromHex(
        String.fromEnvironment('ingester_contract_address')),
    client: web3client,
  );

  try {
    var result = await contractOrchestrator.addGroup(
      'taraxa_project',
      credentials: credentials,
    );
    print(result);
  } on RPCError catch (ex) {
    print(ex);
  } finally {
    await web3client.dispose();
  }
}
