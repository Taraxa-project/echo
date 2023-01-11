import 'package:td_json_client/api/base.dart';


/// Toggles whether non-administrators can receive only administrators and bots using getSupergroupMembers or searchChatMembers. Can be called only if supergroupFullInfo.can_hide_members == true
class ToggleSupergroupHasHiddenMembers extends TdFunction {
  String get tdType => 'toggleSupergroupHasHiddenMembers';
  String get tdReturnType => 'Ok';


  /// Identifier of the supergroup
  int53? supergroup_id;

  /// New value of has_hidden_members
  Bool? has_hidden_members;

  ToggleSupergroupHasHiddenMembers({
    super.extra,
    super.client_id,
    this.supergroup_id,
    this.has_hidden_members,
  });

  ToggleSupergroupHasHiddenMembers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    supergroup_id = map['supergroup_id'];
    has_hidden_members = map['has_hidden_members'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'supergroup_id': supergroup_id?.toMap(skipNulls: skipNulls),
      'has_hidden_members': has_hidden_members?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
