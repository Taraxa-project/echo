import 'package:td_json_client/api/base.dart';

/// Describes the current state of the connection to Telegram servers
abstract class ConnectionState extends TdObject {
  ConnectionState({super.extra, super.client_id});
}


/// Currently waiting for the network to become available. Use setNetworkType to change the available network type
class ConnectionStateWaitingForNetwork extends ConnectionState {
  String get tdType => 'connectionStateWaitingForNetwork';


  ConnectionStateWaitingForNetwork({
    super.extra,
    super.client_id,
  });

  ConnectionStateWaitingForNetwork.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Currently establishing a connection with a proxy server
class ConnectionStateConnectingToProxy extends ConnectionState {
  String get tdType => 'connectionStateConnectingToProxy';


  ConnectionStateConnectingToProxy({
    super.extra,
    super.client_id,
  });

  ConnectionStateConnectingToProxy.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Currently establishing a connection to the Telegram servers
class ConnectionStateConnecting extends ConnectionState {
  String get tdType => 'connectionStateConnecting';


  ConnectionStateConnecting({
    super.extra,
    super.client_id,
  });

  ConnectionStateConnecting.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Downloading data received while the application was offline
class ConnectionStateUpdating extends ConnectionState {
  String get tdType => 'connectionStateUpdating';


  ConnectionStateUpdating({
    super.extra,
    super.client_id,
  });

  ConnectionStateUpdating.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// There is a working connection to the Telegram servers
class ConnectionStateReady extends ConnectionState {
  String get tdType => 'connectionStateReady';


  ConnectionStateReady({
    super.extra,
    super.client_id,
  });

  ConnectionStateReady.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
