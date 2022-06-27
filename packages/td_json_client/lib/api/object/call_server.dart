import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/call_server_type.dart';

class CallServer extends TdObject {
  String get tdType => 'callServer';

  string? extra;
  int? client_id;
  int64? id;
  string? ip_address;
  string? ipv6_address;
  int32? port;
  CallServerType? type;

  CallServer({
    this.extra,
    this.client_id,
    this.id,
    this.ip_address,
    this.ipv6_address,
    this.port,
    this.type,
  });

  CallServer.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    ip_address = map['ip_address'];
    ipv6_address = map['ipv6_address'];
    port = map['port'];
    type = TdApiMap.fromMap(map['type']) as CallServerType;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'ip_address': ip_address?.toMap(skipNulls: skipNulls),
      'ipv6_address': ipv6_address?.toMap(skipNulls: skipNulls),
      'port': port?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
