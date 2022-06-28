import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/proxy_type.dart';


/// Sends a simple network request to the Telegram servers via proxy; for testing only. Can be called before authorization 
class TestProxy extends TdFunction {
  String get tdType => 'testProxy';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Proxy server IP address 
  string? server;

  /// Proxy server port 
  int32? port;

  /// Proxy type
  ProxyType? type;

  /// Identifier of a datacenter with which to test connection 
  int32? dc_id;

  /// The maximum overall timeout for the request
  double? timeout;

  TestProxy({
    this.extra,
    this.client_id,
    this.server,
    this.port,
    this.type,
    this.dc_id,
    this.timeout,
  });

  TestProxy.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    server = map['server'];
    port = map['port'];
    type = TdApiMap.fromMap(map['type']) as ProxyType;
    dc_id = map['dc_id'];
    timeout = map['timeout'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'server': server?.toMap(skipNulls: skipNulls),
      'port': port?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'dc_id': dc_id?.toMap(skipNulls: skipNulls),
      'timeout': timeout?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
