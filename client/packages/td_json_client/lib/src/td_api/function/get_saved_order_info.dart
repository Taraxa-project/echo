import 'package:td_json_client/src/td_api/td.dart';

/// Returns saved order information. Returns a 404 error if there is no saved order information
class GetSavedOrderInfo extends TdFunction {
  String get tdType => 'getSavedOrderInfo';
  String get tdReturnType => 'OrderInfo';

  GetSavedOrderInfo({
    super.extra,
    super.client_id,
  });

  GetSavedOrderInfo.fromMap(Map<String, dynamic> map) {
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
