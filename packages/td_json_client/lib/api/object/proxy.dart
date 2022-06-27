import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/proxy_type.dart';

class Proxy extends TdObject {
  String get tdType => 'proxy';

  String? extra;
  int? client_id;
  int32? id;
  string? server;
  int32? port;
  int32? last_used_date;
  Bool? is_enabled;
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
    type = TdApiMap.fromMap(map['type']) as ProxyType;
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
