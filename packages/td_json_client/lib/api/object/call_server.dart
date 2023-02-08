import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/call_server_type.dart';

/// Describes a server for relaying call data
class CallServer extends TdObject {
  String get tdType => 'callServer';

  /// Server identifier
  int64? id;

  /// Server IPv4 address
  string? ip_address;

  /// Server IPv6 address
  string? ipv6_address;

  /// Server port number
  int32? port;

  /// Server type
  CallServerType? type;

  CallServer({
    super.extra,
    super.client_id,
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
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as CallServerType;
    }
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
