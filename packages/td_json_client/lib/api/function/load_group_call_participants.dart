import 'package:td_json_client/api/base.dart';

class LoadGroupCallParticipants extends TdFunction {
  String get tdType => 'loadGroupCallParticipants';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  int32? group_call_id;
  int32? limit;

  LoadGroupCallParticipants({
    this.extra,
    this.client_id,
    this.group_call_id,
    this.limit,
  });

  LoadGroupCallParticipants.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    group_call_id = map['group_call_id'];
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'group_call_id': group_call_id?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
