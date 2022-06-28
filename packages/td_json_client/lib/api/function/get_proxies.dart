import 'package:td_json_client/api/base.dart';


/// Returns list of proxies that are currently set up. Can be called before authorization
class GetProxies extends TdFunction {
  String get tdType => 'getProxies';
  String get tdReturnType => 'Proxies';

  String? extra;
  int? client_id;

  GetProxies({
    this.extra,
    this.client_id,
  });

  GetProxies.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
