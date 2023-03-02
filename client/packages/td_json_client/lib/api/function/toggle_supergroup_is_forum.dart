import 'package:td_json_client/api/base.dart';


/// Toggles whether the supergroup is a forum; requires owner privileges in the supergroup. Discussion supergroups can't be converted to forums 
class ToggleSupergroupIsForum extends TdFunction {
  String get tdType => 'toggleSupergroupIsForum';
  String get tdReturnType => 'Ok';


  /// Identifier of the supergroup 
  int53? supergroup_id;

  /// New value of is_forum
  Bool? is_forum;

  ToggleSupergroupIsForum({
    super.extra,
    super.client_id,
    this.supergroup_id,
    this.is_forum,
  });

  ToggleSupergroupIsForum.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    supergroup_id = map['supergroup_id'];
    is_forum = map['is_forum'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'supergroup_id': supergroup_id?.toMap(skipNulls: skipNulls),
      'is_forum': is_forum?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
