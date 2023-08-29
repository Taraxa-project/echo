import 'dart:math';

import 'package:web3dart/web3dart.dart';
import 'package:web3dart/crypto.dart';

void main() async {
  for (var i = 0; i < 4; i++) {
    final cred = EthPrivateKey.createRandom(Random.secure());
    print({
      'address': cred.address,
      'public key': bytesToHex(cred.encodedPublicKey),
      'private key': bytesToHex(cred.privateKey)
    });
  }
}
