import 'package:td_json_client/src/td_api/td.dart';

/// Removes a proxy server. Can be called before authorization
class RemoveProxy extends TdFunction {
  String get tdType => 'removeProxy';
  String get tdReturnType => 'Ok';

  /// Proxy identifier
  int32? proxy_id;

  RemoveProxy({
    super.extra,
    super.client_id,
    this.proxy_id,
  });

  RemoveProxy.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    proxy_id = map['proxy_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'proxy_id': proxy_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
