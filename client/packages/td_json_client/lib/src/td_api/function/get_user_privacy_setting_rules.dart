import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/user_privacy_setting.dart';

/// Returns the current privacy settings
class GetUserPrivacySettingRules extends TdFunction {
  String get tdType => 'getUserPrivacySettingRules';
  String get tdReturnType => 'UserPrivacySettingRules';

  /// The privacy setting
  UserPrivacySetting? setting;

  GetUserPrivacySettingRules({
    super.extra,
    super.client_id,
    this.setting,
  });

  GetUserPrivacySettingRules.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['setting'] != null) {
      setting = TdApiMap.fromMap(map['setting']) as UserPrivacySetting;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'setting': setting?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
