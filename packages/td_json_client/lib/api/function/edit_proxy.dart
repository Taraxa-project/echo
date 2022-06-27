import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/proxy_type.dart';

class EditProxy extends TdFunction {
  String get tdType => 'editProxy';
  String get tdReturnType => 'Proxy';

  String? extra;
  int? client_id;
  int32? proxy_id;
  string? server;
  int32? port;
  Bool? enable;
  ProxyType? type;

  EditProxy({
    this.extra,
    this.client_id,
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
    type = TdApiMap.fromMap(map['type']) as ProxyType;
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
