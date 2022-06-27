import 'package:td_json_client/api/base.dart';

class StartScheduledGroupCall extends TdFunction {
  String get tdType => 'startScheduledGroupCall';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  int32? group_call_id;

  StartScheduledGroupCall({
    this.extra,
    this.client_id,
    this.group_call_id,
  });

  StartScheduledGroupCall.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    group_call_id = map['group_call_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'group_call_id': group_call_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
