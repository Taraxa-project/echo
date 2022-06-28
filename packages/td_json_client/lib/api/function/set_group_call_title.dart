import 'package:td_json_client/api/base.dart';


/// Sets group call title. Requires groupCall.can_be_managed group call flag 
class SetGroupCallTitle extends TdFunction {
  String get tdType => 'setGroupCallTitle';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Group call identifier 
  int32? group_call_id;

  /// New group call title; 1-64 characters
  string? title;

  SetGroupCallTitle({
    this.extra,
    this.client_id,
    this.group_call_id,
    this.title,
  });

  SetGroupCallTitle.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    group_call_id = map['group_call_id'];
    title = map['title'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'group_call_id': group_call_id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
