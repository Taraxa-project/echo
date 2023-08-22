import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/firebase_authentication_settings.dart';

/// Contains settings for the authentication of the user's phone number
class PhoneNumberAuthenticationSettings extends TdObject {
  String get tdType => 'phoneNumberAuthenticationSettings';

  /// Pass true if the authentication code may be sent via a flash call to the specified phone number
  Bool? allow_flash_call;

  /// Pass true if the authentication code may be sent via a missed call to the specified phone number
  Bool? allow_missed_call;

  /// Pass true if the authenticated phone number is used on the current device
  Bool? is_current_phone_number;

  /// For official applications only. True, if the application can use Android SMS Retriever API (requires Google Play Services >= 10.2) to automatically receive the authentication code from the SMS. See https://developers.google.com/identity/sms-retriever/ for more details
  Bool? allow_sms_retriever_api;

  /// For official Android and iOS applications only; pass null otherwise. Settings for Firebase Authentication
  FirebaseAuthenticationSettings? firebase_authentication_settings;

  /// List of up to 20 authentication tokens, recently received in updateOption("authentication_token") in previously logged out sessions
  vector<string>? authentication_tokens;

  PhoneNumberAuthenticationSettings({
    super.extra,
    super.client_id,
    this.allow_flash_call,
    this.allow_missed_call,
    this.is_current_phone_number,
    this.allow_sms_retriever_api,
    this.firebase_authentication_settings,
    this.authentication_tokens,
  });

  PhoneNumberAuthenticationSettings.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    allow_flash_call = map['allow_flash_call'];
    allow_missed_call = map['allow_missed_call'];
    is_current_phone_number = map['is_current_phone_number'];
    allow_sms_retriever_api = map['allow_sms_retriever_api'];
    if (map['firebase_authentication_settings'] != null) {
      firebase_authentication_settings = TdApiMap.fromMap(map['firebase_authentication_settings']) as FirebaseAuthenticationSettings;
    }
    if (map['authentication_tokens'] != null) {
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
      'firebase_authentication_settings': firebase_authentication_settings?.toMap(skipNulls: skipNulls),
      'authentication_tokens': authentication_tokens?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
