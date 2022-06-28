import 'package:td_json_client/api/base.dart';


/// Loads more participants of a group call. The loaded participants will be received through updates. Use the field groupCall.loaded_all_participants to check whether all participants have already been loaded
class LoadGroupCallParticipants extends TdFunction {
  String get tdType => 'loadGroupCallParticipants';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Group call identifier. The group call must be previously received through getGroupCall and must be joined or being joined
  int32? group_call_id;

  /// The maximum number of participants to load; up to 100
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
