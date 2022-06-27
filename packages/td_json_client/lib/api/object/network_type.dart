import 'package:td_json_client/api/base.dart';

/// Represents the type of a network
abstract class NetworkType extends TdObject {}


/// The network is not available
class NetworkTypeNone extends NetworkType {
  String get tdType => 'networkTypeNone';

  String? extra;
  int? client_id;

  NetworkTypeNone({
    this.extra,
    this.client_id,
  });

  NetworkTypeNone.fromMap(Map<String, dynamic> map) {
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

/// A mobile network
class NetworkTypeMobile extends NetworkType {
  String get tdType => 'networkTypeMobile';

  String? extra;
  int? client_id;

  NetworkTypeMobile({
    this.extra,
    this.client_id,
  });

  NetworkTypeMobile.fromMap(Map<String, dynamic> map) {
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

/// A mobile roaming network
class NetworkTypeMobileRoaming extends NetworkType {
  String get tdType => 'networkTypeMobileRoaming';

  String? extra;
  int? client_id;

  NetworkTypeMobileRoaming({
    this.extra,
    this.client_id,
  });

  NetworkTypeMobileRoaming.fromMap(Map<String, dynamic> map) {
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

/// A Wi-Fi network
class NetworkTypeWiFi extends NetworkType {
  String get tdType => 'networkTypeWiFi';

  String? extra;
  int? client_id;

  NetworkTypeWiFi({
    this.extra,
    this.client_id,
  });

  NetworkTypeWiFi.fromMap(Map<String, dynamic> map) {
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

/// A different network type (e.g., Ethernet network)
class NetworkTypeOther extends NetworkType {
  String get tdType => 'networkTypeOther';

  String? extra;
  int? client_id;

  NetworkTypeOther({
    this.extra,
    this.client_id,
  });

  NetworkTypeOther.fromMap(Map<String, dynamic> map) {
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
