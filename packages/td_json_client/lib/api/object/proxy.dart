import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/proxy_type.dart';


/// Contains information about a proxy server 
class Proxy extends TdObject {
  String get tdType => 'proxy';

  String? extra;
  int? client_id;

  /// Unique identifier of the proxy 
  int32? id;

  /// Proxy server IP address 
  string? server;

  /// Proxy server port 
  int32? port;

  /// Point in time (Unix timestamp) when the proxy was last used; 0 if never 
  int32? last_used_date;

  /// True, if the proxy is enabled now 
  Bool? is_enabled;

  /// Type of the proxy
  ProxyType? type;

  Proxy({
    this.extra,
    this.client_id,
    this.id,
    this.server,
    this.port,
    this.last_used_date,
    this.is_enabled,
    this.type,
  });

  Proxy.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    server = map['server'];
    port = map['port'];
    last_used_date = map['last_used_date'];
    is_enabled = map['is_enabled'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as ProxyType;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'server': server?.toMap(skipNulls: skipNulls),
      'port': port?.toMap(skipNulls: skipNulls),
      'last_used_date': last_used_date?.toMap(skipNulls: skipNulls),
      'is_enabled': is_enabled?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
