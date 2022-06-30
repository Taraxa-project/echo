import 'package:td_json_client/api/base.dart';


/// Returns application config, provided by the server. Can be called before authorization
class GetApplicationConfig extends TdFunction {
  String get tdType => 'getApplicationConfig';
  String get tdReturnType => 'JsonValue';


  GetApplicationConfig({
    super.extra,
    super.client_id,
  });

  GetApplicationConfig.fromMap(Map<String, dynamic> map) {
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
