import 'package:td_json_client/api/base.dart';


/// Returns the current user
class GetMe extends TdFunction {
  String get tdType => 'getMe';
  String get tdReturnType => 'User';


  GetMe({
    super.extra,
    super.client_id,
  });

  GetMe.fromMap(Map<String, dynamic> map) {
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
