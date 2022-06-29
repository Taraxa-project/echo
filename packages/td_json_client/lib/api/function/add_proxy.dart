import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/proxy_type.dart';


/// Adds a proxy server for network requests. Can be called before authorization 
class AddProxy extends TdFunction {
  String get tdType => 'addProxy';
  String get tdReturnType => 'Proxy';

  String? extra;
  int? client_id;

  /// Proxy server IP address 
  string? server;

  /// Proxy server port 
  int32? port;

  /// True, if the proxy needs to be enabled 
  Bool? enable;

  /// Proxy type
  ProxyType? type;

  AddProxy({
    this.extra,
    this.client_id,
    this.server,
    this.port,
    this.enable,
    this.type,
  });

  AddProxy.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    server = map['server'];
    port = map['port'];
    enable = map['enable'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as ProxyType;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'server': server?.toMap(skipNulls: skipNulls),
      'port': port?.toMap(skipNulls: skipNulls),
      'enable': enable?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
