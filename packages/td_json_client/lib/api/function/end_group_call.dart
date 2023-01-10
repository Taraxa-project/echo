import 'package:td_json_client/api/base.dart';


/// Ends a group call. Requires groupCall.can_be_managed 
class EndGroupCall extends TdFunction {
  String get tdType => 'endGroupCall';
  String get tdReturnType => 'Ok';


  /// Group call identifier
  int32? group_call_id;

  EndGroupCall({
    super.extra,
    super.client_id,
    this.group_call_id,
  });

  EndGroupCall.fromMap(Map<String, dynamic> map) {
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
