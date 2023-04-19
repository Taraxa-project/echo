import 'package:td_json_client/src/td_api/td.dart';

/// Returns default message auto-delete time setting for new chats
class GetDefaultMessageAutoDeleteTime extends TdFunction {
  String get tdType => 'getDefaultMessageAutoDeleteTime';
  String get tdReturnType => 'MessageAutoDeleteTime';

  GetDefaultMessageAutoDeleteTime({
    super.extra,
    super.client_id,
  });

  GetDefaultMessageAutoDeleteTime.fromMap(Map<String, dynamic> map) {
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
