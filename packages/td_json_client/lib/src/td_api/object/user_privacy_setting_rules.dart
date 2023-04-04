import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/user_privacy_setting_rule.dart';

/// A list of privacy rules. Rules are matched in the specified order. The first matched rule defines the privacy setting for a given user. If no rule matches, the action is not allowed
class UserPrivacySettingRules extends TdObject {
  String get tdType => 'userPrivacySettingRules';

  /// A list of rules
  vector<UserPrivacySettingRule>? rules;

  UserPrivacySettingRules({
    super.extra,
    super.client_id,
    this.rules,
  });

  UserPrivacySettingRules.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['rules'] != null) {
      rules = [];
      for (var someValue in map['rules']) {
        if (someValue != null) {
          rules?.add(TdApiMap.fromMap(someValue) as UserPrivacySettingRule);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'rules': rules?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
