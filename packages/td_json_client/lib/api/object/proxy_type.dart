import 'package:td_json_client/api/base.dart';

abstract class ProxyType extends TdObject {}

class ProxyTypeSocks5 extends ProxyType {
  String get tdType => 'proxyTypeSocks5';

  String? extra;
  int? client_id;
  string? username;
  string? password;

  ProxyTypeSocks5({
    this.extra,
    this.client_id,
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
class ProxyTypeHttp extends ProxyType {
  String get tdType => 'proxyTypeHttp';

  String? extra;
  int? client_id;
  string? username;
  string? password;
  Bool? http_only;

  ProxyTypeHttp({
    this.extra,
    this.client_id,
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
class ProxyTypeMtproto extends ProxyType {
  String get tdType => 'proxyTypeMtproto';

  String? extra;
  int? client_id;
  string? secret;

  ProxyTypeMtproto({
    this.extra,
    this.client_id,
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
