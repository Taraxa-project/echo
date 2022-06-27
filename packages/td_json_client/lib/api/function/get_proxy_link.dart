import 'package:td_json_client/api/base.dart';

class GetProxyLink extends TdFunction {
  String get tdType => 'getProxyLink';
  String get tdReturnType => 'HttpUrl';

  string? extra;
  int? client_id;
  int32? proxy_id;

  GetProxyLink({
    this.extra,
    this.client_id,
    this.proxy_id,
  });

  GetProxyLink.fromMap(Map<String, dynamic> map) {
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
