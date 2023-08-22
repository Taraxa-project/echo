import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/phone_number_authentication_settings.dart';

/// Changes the phone number of the user and sends an authentication code to the user's new phone number; for official Android and iOS applications only. On success, returns information about the sent code
class ChangePhoneNumber extends TdFunction {
  String get tdType => 'changePhoneNumber';
  String get tdReturnType => 'AuthenticationCodeInfo';

  /// The new phone number of the user in international format
  string? phone_number;

  /// Settings for the authentication of the user's phone number; pass null to use default settings
  PhoneNumberAuthenticationSettings? settings;

  ChangePhoneNumber({
    super.extra,
    super.client_id,
    this.phone_number,
    this.settings,
  });

  ChangePhoneNumber.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    phone_number = map['phone_number'];
    if (map['settings'] != null) {
      settings = TdApiMap.fromMap(map['settings']) as PhoneNumberAuthenticationSettings;
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
