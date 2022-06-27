import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/user_privacy_setting.dart';

class GetUserPrivacySettingRules extends TdFunction {
  String get tdType => 'getUserPrivacySettingRules';
  String get tdReturnType => 'UserPrivacySettingRules';

  string? extra;
  int? client_id;
  UserPrivacySetting? setting;

  GetUserPrivacySettingRules({
    this.extra,
    this.client_id,
    this.setting,
  });

  GetUserPrivacySettingRules.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    setting = TdApiMap.fromMap(map['setting']) as UserPrivacySetting;
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
