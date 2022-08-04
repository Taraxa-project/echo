import 'package:td_json_client/api/base.dart';


/// Toggles whether all users directly joining the supergroup need to be approved by supergroup administrators; requires can_restrict_members administrator right 
class ToggleSupergroupJoinByRequest extends TdFunction {
  String get tdType => 'toggleSupergroupJoinByRequest';
  String get tdReturnType => 'Ok';


  /// Identifier of the channel 
  int53? supergroup_id;

  /// New value of join_by_request
  Bool? join_by_request;

  ToggleSupergroupJoinByRequest({
    super.extra,
    super.client_id,
    this.supergroup_id,
    this.join_by_request,
  });

  ToggleSupergroupJoinByRequest.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    supergroup_id = map['supergroup_id'];
    join_by_request = map['join_by_request'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'supergroup_id': supergroup_id?.toMap(skipNulls: skipNulls),
      'join_by_request': join_by_request?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
