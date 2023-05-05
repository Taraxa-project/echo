// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;
import 'dart:typed_data' as _i2;

final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"inputs":[],"name":"UintUtils__InsufficientHexLength","type":"error"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"newIngesterProxy","type":"address"}],"name":"IngesterProxyAddressUpdated","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"ingesterAddress","type":"address"},{"indexed":false,"internalType":"string","name":"usersIpfsHash","type":"string"},{"indexed":false,"internalType":"string","name":"chatsIpfsHash","type":"string"},{"indexed":false,"internalType":"string","name":"messagesIpfsHash","type":"string"}],"name":"IpfsHashAdded","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"bytes32","name":"role","type":"bytes32"},{"indexed":true,"internalType":"bytes32","name":"previousAdminRole","type":"bytes32"},{"indexed":true,"internalType":"bytes32","name":"newAdminRole","type":"bytes32"}],"name":"RoleAdminChanged","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"bytes32","name":"role","type":"bytes32"},{"indexed":true,"internalType":"address","name":"account","type":"address"},{"indexed":true,"internalType":"address","name":"sender","type":"address"}],"name":"RoleGranted","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"bytes32","name":"role","type":"bytes32"},{"indexed":true,"internalType":"address","name":"account","type":"address"},{"indexed":true,"internalType":"address","name":"sender","type":"address"}],"name":"RoleRevoked","type":"event"},{"inputs":[{"internalType":"string","name":"usersHash","type":"string"},{"internalType":"string","name":"chatsHash","type":"string"},{"internalType":"string","name":"messagesHash","type":"string"}],"name":"addIpfsHash","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"numerator","type":"uint256"},{"internalType":"uint256","name":"denominator","type":"uint256"}],"name":"divideAndRoundUp","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"pure","type":"function"},{"inputs":[{"internalType":"uint256","name":"clusterId","type":"uint256"}],"name":"getCluster","outputs":[{"components":[{"internalType":"address[]","name":"ingesterAddresses","type":"address[]"},{"internalType":"uint256","name":"clusterGroupCount","type":"uint256"},{"internalType":"uint256","name":"clusterRemainingCapacity","type":"uint256"}],"internalType":"struct IIngesterGroupManager.ClusterSlim","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getClusters","outputs":[{"internalType":"uint256[]","name":"","type":"uint256[]"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"controllerAddress","type":"address"}],"name":"getControllerIngesters","outputs":[{"components":[{"internalType":"address","name":"ingesterAddress","type":"address"},{"internalType":"bool","name":"verified","type":"bool"},{"internalType":"uint256","name":"clusterId","type":"uint256"}],"internalType":"struct IIngesterRegistration.Ingester[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getGroupCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"ingesterAddress","type":"address"}],"name":"getIngester","outputs":[{"components":[{"internalType":"address","name":"ingesterAddress","type":"address"},{"internalType":"bool","name":"verified","type":"bool"},{"internalType":"uint256","name":"clusterId","type":"uint256"}],"internalType":"struct IIngesterRegistration.Ingester","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getIngesterCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"ingesterAddress","type":"address"}],"name":"getIngesterWithGroups","outputs":[{"components":[{"internalType":"address","name":"ingesterAddress","type":"address"},{"internalType":"bool","name":"verified","type":"bool"},{"internalType":"uint256","name":"clusterId","type":"uint256"},{"internalType":"string[]","name":"assignedGroups","type":"string[]"}],"internalType":"struct IIngesterRegistration.IngesterWithGroups","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getIngesters","outputs":[{"internalType":"address[]","name":"","type":"address[]"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"ingesterAddress","type":"address"}],"name":"getIpfsHashes","outputs":[{"components":[{"internalType":"string","name":"usersIpfsHash","type":"string"},{"internalType":"string","name":"chatsIpfsHash","type":"string"},{"internalType":"string","name":"messagesIpfsHash","type":"string"}],"internalType":"struct IIngesterDataGathering.IpfsHash","name":"ipfsHashes","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"role","type":"bytes32"}],"name":"getRoleAdmin","outputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getUnallocatedGroups","outputs":[{"internalType":"string[]","name":"","type":"string[]"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"role","type":"bytes32"},{"internalType":"address","name":"account","type":"address"}],"name":"grantRole","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes32","name":"role","type":"bytes32"},{"internalType":"address","name":"account","type":"address"}],"name":"hasRole","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"ingester","type":"address"},{"internalType":"address","name":"controller","type":"address"}],"name":"isIngesterOwnedByController","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"controller","type":"address"}],"name":"isRegisteredController","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"ingesterAddress","type":"address"}],"name":"isRegisteredIngester","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"role","type":"bytes32"}],"name":"renounceRole","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes32","name":"role","type":"bytes32"},{"internalType":"address","name":"account","type":"address"}],"name":"revokeRole","outputs":[],"stateMutability":"nonpayable","type":"function"}]',
  'DataGatheringFacet',
);

class DataGatheringFacet extends _i1.GeneratedContract {
  DataGatheringFacet({
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

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> addIpfsHash(
    String usersHash,
    String chatsHash,
    String messagesHash, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[0];
    assert(checkSignature(function, '812e53d2'));
    final params = [
      usersHash,
      chatsHash,
      messagesHash,
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
  Future<BigInt> divideAndRoundUp(
    BigInt numerator,
    BigInt denominator, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, 'fd3bad52'));
    final params = [
      numerator,
      denominator,
    ];
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
  Future<dynamic> getCluster(
    BigInt clusterId, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '0179240c'));
    final params = [clusterId];
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
  Future<List<BigInt>> getClusters({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, '16f1d42a'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as List<dynamic>).cast<BigInt>();
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<dynamic>> getControllerIngesters(
    _i1.EthereumAddress controllerAddress, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, 'be43fb6c'));
    final params = [controllerAddress];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as List<dynamic>).cast<dynamic>();
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> getGroupCount({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[5];
    assert(checkSignature(function, '06545a93'));
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
    final function = self.abi.functions[6];
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
  Future<BigInt> getIngesterCount({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[7];
    assert(checkSignature(function, '59492090'));
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
  Future<dynamic> getIngesterWithGroups(
    _i1.EthereumAddress ingesterAddress, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[8];
    assert(checkSignature(function, '978abee0'));
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
  Future<List<_i1.EthereumAddress>> getIngesters(
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[9];
    assert(checkSignature(function, '32fa7d21'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as List<dynamic>).cast<_i1.EthereumAddress>();
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<dynamic> getIpfsHashes(
    _i1.EthereumAddress ingesterAddress, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[10];
    assert(checkSignature(function, '1a5d7f3e'));
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
    final function = self.abi.functions[11];
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
  Future<List<String>> getUnallocatedGroups({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[12];
    assert(checkSignature(function, 'c9926a9e'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as List<dynamic>).cast<String>();
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
    final function = self.abi.functions[13];
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
    final function = self.abi.functions[14];
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
  Future<bool> isIngesterOwnedByController(
    _i1.EthereumAddress ingester,
    _i1.EthereumAddress controller, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[15];
    assert(checkSignature(function, '307f4f0a'));
    final params = [
      ingester,
      controller,
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
  Future<bool> isRegisteredController(
    _i1.EthereumAddress controller, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[16];
    assert(checkSignature(function, '8cdcb3e6'));
    final params = [controller];
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
  Future<bool> isRegisteredIngester(
    _i1.EthereumAddress ingesterAddress, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[17];
    assert(checkSignature(function, '5e91a74a'));
    final params = [ingesterAddress];
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
  Future<String> renounceRole(
    _i2.Uint8List role, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[18];
    assert(checkSignature(function, '8bb9c5bf'));
    final params = [role];
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
    final function = self.abi.functions[19];
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

  /// Returns a live stream of all IngesterProxyAddressUpdated events emitted by this contract.
  Stream<IngesterProxyAddressUpdated> ingesterProxyAddressUpdatedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('IngesterProxyAddressUpdated');
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
      return IngesterProxyAddressUpdated(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all IpfsHashAdded events emitted by this contract.
  Stream<IpfsHashAdded> ipfsHashAddedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('IpfsHashAdded');
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
      return IpfsHashAdded(
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

class IngesterProxyAddressUpdated {
  IngesterProxyAddressUpdated(
    List<dynamic> response,
    this.event,
  ) : newIngesterProxy = (response[0] as _i1.EthereumAddress);

  final _i1.EthereumAddress newIngesterProxy;

  final _i1.FilterEvent event;
}

class IpfsHashAdded {
  IpfsHashAdded(
    List<dynamic> response,
    this.event,
  )   : ingesterAddress = (response[0] as _i1.EthereumAddress),
        usersIpfsHash = (response[1] as String),
        chatsIpfsHash = (response[2] as String),
        messagesIpfsHash = (response[3] as String);

  final _i1.EthereumAddress ingesterAddress;

  final String usersIpfsHash;

  final String chatsIpfsHash;

  final String messagesIpfsHash;

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
