import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/phone_number_authentication_settings.dart';

class SendPhoneNumberVerificationCode extends TdFunction {
  String get tdType => 'sendPhoneNumberVerificationCode';
  String get tdReturnType => 'AuthenticationCodeInfo';

  String? extra;
  int? client_id;
  string? phone_number;
  PhoneNumberAuthenticationSettings? settings;

  SendPhoneNumberVerificationCode({
    this.extra,
    this.client_id,
    this.phone_number,
    this.settings,
  });

  SendPhoneNumberVerificationCode.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    phone_number = map['phone_number'];
    settings = TdApiMap.fromMap(map['settings']) as PhoneNumberAuthenticationSettings;
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
