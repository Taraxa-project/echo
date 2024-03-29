import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/proxy_type.dart';

/// Edits an existing proxy server for network requests. Can be called before authorization
class EditProxy extends TdFunction {
  String get tdType => 'editProxy';
  String get tdReturnType => 'Proxy';

  /// Proxy identifier
  int32? proxy_id;

  /// Proxy server IP address
  string? server;

  /// Proxy server port
  int32? port;

  /// Pass true to immediately enable the proxy
  Bool? enable;

  /// Proxy type
  ProxyType? type;

  EditProxy({
    super.extra,
    super.client_id,
    this.proxy_id,
    this.server,
    this.port,
    this.enable,
    this.type,
  });

  EditProxy.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    proxy_id = map['proxy_id'];
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
      'proxy_id': proxy_id?.toMap(skipNulls: skipNulls),
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
