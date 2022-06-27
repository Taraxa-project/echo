import 'package:td_json_client/api/base.dart';

abstract class ConnectionState extends TdObject {}

class ConnectionStateWaitingForNetwork extends ConnectionState {
  String get tdType => 'connectionStateWaitingForNetwork';

  string? extra;
  int? client_id;

  ConnectionStateWaitingForNetwork({
    this.extra,
    this.client_id,
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
class ConnectionStateConnectingToProxy extends ConnectionState {
  String get tdType => 'connectionStateConnectingToProxy';

  string? extra;
  int? client_id;

  ConnectionStateConnectingToProxy({
    this.extra,
    this.client_id,
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
class ConnectionStateConnecting extends ConnectionState {
  String get tdType => 'connectionStateConnecting';

  string? extra;
  int? client_id;

  ConnectionStateConnecting({
    this.extra,
    this.client_id,
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
class ConnectionStateUpdating extends ConnectionState {
  String get tdType => 'connectionStateUpdating';

  string? extra;
  int? client_id;

  ConnectionStateUpdating({
    this.extra,
    this.client_id,
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
class ConnectionStateReady extends ConnectionState {
  String get tdType => 'connectionStateReady';

  string? extra;
  int? client_id;

  ConnectionStateReady({
    this.extra,
    this.client_id,
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
