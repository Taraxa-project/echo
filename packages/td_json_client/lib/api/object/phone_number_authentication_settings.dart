import 'package:td_json_client/api/base.dart';

class PhoneNumberAuthenticationSettings extends TdObject {
  String get tdType => 'phoneNumberAuthenticationSettings';

  string? extra;
  int? client_id;
  Bool? allow_flash_call;
  Bool? allow_missed_call;
  Bool? is_current_phone_number;
  Bool? allow_sms_retriever_api;
  vector<string>? authentication_tokens;

  PhoneNumberAuthenticationSettings({
    this.extra,
    this.client_id,
    this.allow_flash_call,
    this.allow_missed_call,
    this.is_current_phone_number,
    this.allow_sms_retriever_api,
    this.authentication_tokens,
  });

  PhoneNumberAuthenticationSettings.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    allow_flash_call = map['allow_flash_call'];
    allow_missed_call = map['allow_missed_call'];
    is_current_phone_number = map['is_current_phone_number'];
    allow_sms_retriever_api = map['allow_sms_retriever_api'];
    if (map['authentication_tokens']) {
      authentication_tokens = [];
      for (var someValue in map['authentication_tokens']) {
        authentication_tokens?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'allow_flash_call': allow_flash_call?.toMap(skipNulls: skipNulls),
      'allow_missed_call': allow_missed_call?.toMap(skipNulls: skipNulls),
      'is_current_phone_number': is_current_phone_number?.toMap(skipNulls: skipNulls),
      'allow_sms_retriever_api': allow_sms_retriever_api?.toMap(skipNulls: skipNulls),
      'authentication_tokens': authentication_tokens?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
