import 'package:td_json_client/src/td_api/td.dart';

/// Describes the type of a proxy server
abstract class ProxyType extends TdObject {
  ProxyType({super.extra, super.client_id});
}

/// A SOCKS5 proxy server
class ProxyTypeSocks5 extends ProxyType {
  String get tdType => 'proxyTypeSocks5';

  /// Username for logging in; may be empty
  string? username;

  /// Password for logging in; may be empty
  string? password;

  ProxyTypeSocks5({
    super.extra,
    super.client_id,
    this.username,
    this.password,
  });

  ProxyTypeSocks5.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    username = map['username'];
    password = map['password'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'username': username?.toMap(skipNulls: skipNulls),
      'password': password?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A HTTP transparent proxy server
class ProxyTypeHttp extends ProxyType {
  String get tdType => 'proxyTypeHttp';

  /// Username for logging in; may be empty
  string? username;

  /// Password for logging in; may be empty
  string? password;

  /// Pass true if the proxy supports only HTTP requests and doesn't support transparent TCP connections via HTTP CONNECT method
  Bool? http_only;

  ProxyTypeHttp({
    super.extra,
    super.client_id,
    this.username,
    this.password,
    this.http_only,
  });

  ProxyTypeHttp.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    username = map['username'];
    password = map['password'];
    http_only = map['http_only'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'username': username?.toMap(skipNulls: skipNulls),
      'password': password?.toMap(skipNulls: skipNulls),
      'http_only': http_only?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// An MTProto proxy server
class ProxyTypeMtproto extends ProxyType {
  String get tdType => 'proxyTypeMtproto';

  /// The proxy's secret in hexadecimal encoding
  string? secret;

  ProxyTypeMtproto({
    super.extra,
    super.client_id,
    this.secret,
  });

  ProxyTypeMtproto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    secret = map['secret'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'secret': secret?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
