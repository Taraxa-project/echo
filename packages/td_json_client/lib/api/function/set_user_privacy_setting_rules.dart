import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/user_privacy_setting.dart';
import 'package:td_json_client/api/object/user_privacy_setting_rules.dart';

class SetUserPrivacySettingRules extends TdFunction {
  String get tdType => 'setUserPrivacySettingRules';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  UserPrivacySetting? setting;
  UserPrivacySettingRules? rules;

  SetUserPrivacySettingRules({
    this.extra,
    this.client_id,
    this.setting,
    this.rules,
  });

  SetUserPrivacySettingRules.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    setting = TdApiMap.fromMap(map['setting']) as UserPrivacySetting;
    rules = TdApiMap.fromMap(map['rules']) as UserPrivacySettingRules;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'setting': setting?.toMap(skipNulls: skipNulls),
      'rules': rules?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
