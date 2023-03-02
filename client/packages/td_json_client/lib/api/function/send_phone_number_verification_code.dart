import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/phone_number_authentication_settings.dart';

/// Sends a code to verify a phone number to be added to a user's Telegram Passport
class SendPhoneNumberVerificationCode extends TdFunction {
  String get tdType => 'sendPhoneNumberVerificationCode';
  String get tdReturnType => 'AuthenticationCodeInfo';

  /// The phone number of the user, in international format
  string? phone_number;

  /// Settings for the authentication of the user's phone number; pass null to use default settings
  PhoneNumberAuthenticationSettings? settings;

  SendPhoneNumberVerificationCode({
    super.extra,
    super.client_id,
    this.phone_number,
    this.settings,
  });

  SendPhoneNumberVerificationCode.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    phone_number = map['phone_number'];
    if (map['settings'] != null) {
      settings = TdApiMap.fromMap(map['settings'])
          as PhoneNumberAuthenticationSettings;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'phone_number': phone_number?.toMap(skipNulls: skipNulls),
      'settings': settings?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
