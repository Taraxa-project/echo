// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;
import 'dart:typed_data' as _i2;

final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"controllerAddress","type":"address"},{"indexed":true,"internalType":"address","name":"ingesterAddress","type":"address"}],"name":"IngesterRegistered","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"controllerAddress","type":"address"},{"indexed":true,"internalType":"address","name":"ingesterAddress","type":"address"}],"name":"IngesterUnRegistered","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"previousOwner","type":"address"},{"indexed":true,"internalType":"address","name":"newOwner","type":"address"}],"name":"OwnershipTransferred","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"bytes32","name":"role","type":"bytes32"},{"indexed":true,"internalType":"bytes32","name":"previousAdminRole","type":"bytes32"},{"indexed":true,"internalType":"bytes32","name":"newAdminRole","type":"bytes32"}],"name":"RoleAdminChanged","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"bytes32","name":"role","type":"bytes32"},{"indexed":true,"internalType":"address","name":"account","type":"address"},{"indexed":true,"internalType":"address","name":"sender","type":"address"}],"name":"RoleGranted","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"bytes32","name":"role","type":"bytes32"},{"indexed":true,"internalType":"address","name":"account","type":"address"},{"indexed":true,"internalType":"address","name":"sender","type":"address"}],"name":"RoleRevoked","type":"event"},{"inputs":[],"name":"DEFAULT_ADMIN_ROLE","outputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"INGESTER_ROLE","outputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_address","type":"address"},{"internalType":"string","name":"_value","type":"string"},{"internalType":"uint256","name":"_nonce","type":"uint256"}],"name":"_hash","outputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"stateMutability":"pure","type":"function"},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"_ingesterAddresses","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"_ingesterCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"ingesterAddress","type":"address"}],"name":"getIngester","outputs":[{"components":[{"internalType":"address","name":"ingesterAddress","type":"address"},{"internalType":"bool","name":"verified","type":"bool"},{"internalType":"string[]","name":"assignedGroups","type":"string[]"}],"internalType":"struct IIngesterRegistrationV2.Ingester","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"role","type":"bytes32"}],"name":"getRoleAdmin","outputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"role","type":"bytes32"},{"internalType":"uint256","name":"index","type":"uint256"}],"name":"getRoleMember","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"role","type":"bytes32"}],"name":"getRoleMemberCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"role","type":"bytes32"},{"internalType":"address","name":"account","type":"address"}],"name":"grantRole","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes32","name":"role","type":"bytes32"},{"internalType":"address","name":"account","type":"address"}],"name":"hasRole","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"owner","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"ingesterAddress","type":"address"},{"internalType":"string","name":"message","type":"string"},{"internalType":"uint256","name":"nonce","type":"uint256"},{"internalType":"bytes","name":"sig","type":"bytes"}],"name":"registerIngester","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"renounceOwnership","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes32","name":"role","type":"bytes32"},{"internalType":"address","name":"account","type":"address"}],"name":"renounceRole","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes32","name":"role","type":"bytes32"},{"internalType":"address","name":"account","type":"address"}],"name":"revokeRole","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes4","name":"interfaceId","type":"bytes4"}],"name":"supportsInterface","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"newOwner","type":"address"}],"name":"transferOwnership","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"ingesterAddress","type":"address"},{"internalType":"address","name":"originCaller","type":"address"}],"name":"unRegisteringIngester","outputs":[{"internalType":"string[]","name":"groups","type":"string[]"}],"stateMutability":"nonpayable","type":"function"}]',
  'IngesterRegistrationV2',
);

class IngesterRegistrationV2 extends _i1.GeneratedContract {
  IngesterRegistrationV2({
    required _i1.EthereumAddress address,
    required _i1.Web3Client client,
    int? chainId,
  }) : super(
          _i1.DeployedContract(
            _contractAbi,
            address,
          ),
          client,
          chainId,
        );

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i2.Uint8List> DEFAULT_ADMIN_ROLE({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[0];
    assert(checkSignature(function, 'a217fddf'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as _i2.Uint8List);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i2.Uint8List> INGESTER_ROLE({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, '213d1235'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as _i2.Uint8List);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i2.Uint8List> _hash(
    _i1.EthereumAddress _address,
    String _value,
    BigInt _nonce, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '33bdff78'));
    final params = [
      _address,
      _value,
      _nonce,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as _i2.Uint8List);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i2.Uint8List> hash(
    _i1.EthereumAddress _address,
    String _value,
    BigInt _nonce, {
    _i1.BlockNum? atBlock,
  }) async {
    return await _hash(_address, _value, _nonce, atBlock: atBlock);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i1.EthereumAddress> _ingesterAddresses(
    BigInt $param3, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, '3667e6fe'));
    final params = [$param3];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as _i1.EthereumAddress);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> _ingesterCount({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, '15604410'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<dynamic> getIngester(
    _i1.EthereumAddress ingesterAddress, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[5];
    assert(checkSignature(function, 'c4df5007'));
    final params = [ingesterAddress];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as dynamic);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i2.Uint8List> getRoleAdmin(
    _i2.Uint8List role, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[6];
    assert(checkSignature(function, '248a9ca3'));
    final params = [role];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as _i2.Uint8List);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i1.EthereumAddress> getRoleMember(
    _i2.Uint8List role,
    BigInt index, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[7];
    assert(checkSignature(function, '9010d07c'));
    final params = [
      role,
      index,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as _i1.EthereumAddress);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> getRoleMemberCount(
    _i2.Uint8List role, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[8];
    assert(checkSignature(function, 'ca15c873'));
    final params = [role];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> grantRole(
    _i2.Uint8List role,
    _i1.EthereumAddress account, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[9];
    assert(checkSignature(function, '2f2ff15d'));
    final params = [
      role,
      account,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<bool> hasRole(
    _i2.Uint8List role,
    _i1.EthereumAddress account, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[10];
    assert(checkSignature(function, '91d14854'));
    final params = [
      role,
      account,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as bool);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i1.EthereumAddress> owner({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[11];
    assert(checkSignature(function, '8da5cb5b'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as _i1.EthereumAddress);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> registerIngester(
    _i1.EthereumAddress ingesterAddress,
    String message,
    BigInt nonce,
    _i2.Uint8List sig, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[12];
    assert(checkSignature(function, 'b3d1dba6'));
    final params = [
      ingesterAddress,
      message,
      nonce,
      sig,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> renounceOwnership({
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[13];
    assert(checkSignature(function, '715018a6'));
    final params = [];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> renounceRole(
    _i2.Uint8List role,
    _i1.EthereumAddress account, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[14];
    assert(checkSignature(function, '36568abe'));
    final params = [
      role,
      account,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> revokeRole(
    _i2.Uint8List role,
    _i1.EthereumAddress account, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[15];
    assert(checkSignature(function, 'd547741f'));
    final params = [
      role,
      account,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<bool> supportsInterface(
    _i2.Uint8List interfaceId, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[16];
    assert(checkSignature(function, '01ffc9a7'));
    final params = [interfaceId];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as bool);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> transferOwnership(
    _i1.EthereumAddress newOwner, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[17];
    assert(checkSignature(function, 'f2fde38b'));
    final params = [newOwner];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> unRegisteringIngester(
    _i1.EthereumAddress ingesterAddress,
    _i1.EthereumAddress originCaller, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[18];
    assert(checkSignature(function, '046fb9aa'));
    final params = [
      ingesterAddress,
      originCaller,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// Returns a live stream of all IngesterRegistered events emitted by this contract.
  Stream<IngesterRegistered> ingesterRegisteredEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('IngesterRegistered');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return IngesterRegistered(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all IngesterUnRegistered events emitted by this contract.
  Stream<IngesterUnRegistered> ingesterUnRegisteredEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('IngesterUnRegistered');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return IngesterUnRegistered(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all OwnershipTransferred events emitted by this contract.
  Stream<OwnershipTransferred> ownershipTransferredEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('OwnershipTransferred');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return OwnershipTransferred(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all RoleAdminChanged events emitted by this contract.
  Stream<RoleAdminChanged> roleAdminChangedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('RoleAdminChanged');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return RoleAdminChanged(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all RoleGranted events emitted by this contract.
  Stream<RoleGranted> roleGrantedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('RoleGranted');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return RoleGranted(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all RoleRevoked events emitted by this contract.
  Stream<RoleRevoked> roleRevokedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('RoleRevoked');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return RoleRevoked(
        decoded,
        result,
      );
    });
  }
}

class IngesterRegistered {
  IngesterRegistered(
    List<dynamic> response,
    this.event,
  )   : controllerAddress = (response[0] as _i1.EthereumAddress),
        ingesterAddress = (response[1] as _i1.EthereumAddress);

  final _i1.EthereumAddress controllerAddress;

  final _i1.EthereumAddress ingesterAddress;

  final _i1.FilterEvent event;
}

class IngesterUnRegistered {
  IngesterUnRegistered(
    List<dynamic> response,
    this.event,
  )   : controllerAddress = (response[0] as _i1.EthereumAddress),
        ingesterAddress = (response[1] as _i1.EthereumAddress);

  final _i1.EthereumAddress controllerAddress;

  final _i1.EthereumAddress ingesterAddress;

  final _i1.FilterEvent event;
}

class OwnershipTransferred {
  OwnershipTransferred(
    List<dynamic> response,
    this.event,
  )   : previousOwner = (response[0] as _i1.EthereumAddress),
        newOwner = (response[1] as _i1.EthereumAddress);

  final _i1.EthereumAddress previousOwner;

  final _i1.EthereumAddress newOwner;

  final _i1.FilterEvent event;
}

class RoleAdminChanged {
  RoleAdminChanged(
    List<dynamic> response,
    this.event,
  )   : role = (response[0] as _i2.Uint8List),
        previousAdminRole = (response[1] as _i2.Uint8List),
        newAdminRole = (response[2] as _i2.Uint8List);

  final _i2.Uint8List role;

  final _i2.Uint8List previousAdminRole;

  final _i2.Uint8List newAdminRole;

  final _i1.FilterEvent event;
}

class RoleGranted {
  RoleGranted(
    List<dynamic> response,
    this.event,
  )   : role = (response[0] as _i2.Uint8List),
        account = (response[1] as _i1.EthereumAddress),
        sender = (response[2] as _i1.EthereumAddress);

  final _i2.Uint8List role;

  final _i1.EthereumAddress account;

  final _i1.EthereumAddress sender;

  final _i1.FilterEvent event;
}

class RoleRevoked {
  RoleRevoked(
    List<dynamic> response,
    this.event,
  )   : role = (response[0] as _i2.Uint8List),
        account = (response[1] as _i1.EthereumAddress),
        sender = (response[2] as _i1.EthereumAddress);

  final _i2.Uint8List role;

  final _i1.EthereumAddress account;

  final _i1.EthereumAddress sender;

  final _i1.FilterEvent event;
}
