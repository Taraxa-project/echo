import 'package:td_json_client/api/base.dart';


/// Toggles whether aggressive anti-spam checks are enabled in the supergroup. Can be called only if supergroupFullInfo.can_toggle_aggressive_anti_spam == true
class ToggleSupergroupHasAggressiveAntiSpamEnabled extends TdFunction {
  String get tdType => 'toggleSupergroupHasAggressiveAntiSpamEnabled';
  String get tdReturnType => 'Ok';


  /// The identifier of the supergroup, which isn't a broadcast group
  int53? supergroup_id;

  /// The new value of has_aggressive_anti_spam_enabled
  Bool? has_aggressive_anti_spam_enabled;

  ToggleSupergroupHasAggressiveAntiSpamEnabled({
    super.extra,
    super.client_id,
    this.supergroup_id,
    this.has_aggressive_anti_spam_enabled,
  });

  ToggleSupergroupHasAggressiveAntiSpamEnabled.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    supergroup_id = map['supergroup_id'];
    has_aggressive_anti_spam_enabled = map['has_aggressive_anti_spam_enabled'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'supergroup_id': supergroup_id?.toMap(skipNulls: skipNulls),
      'has_aggressive_anti_spam_enabled': has_aggressive_anti_spam_enabled?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
