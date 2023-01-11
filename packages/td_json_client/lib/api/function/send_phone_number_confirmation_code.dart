import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/phone_number_authentication_settings.dart';


/// Sends phone number confirmation code to handle links of the type internalLinkTypePhoneNumberConfirmation
class SendPhoneNumberConfirmationCode extends TdFunction {
  String get tdType => 'sendPhoneNumberConfirmationCode';
  String get tdReturnType => 'AuthenticationCodeInfo';


  /// Hash value from the link
  string? hash;

  /// Phone number value from the link
  string? phone_number;

  /// Settings for the authentication of the user's phone number; pass null to use default settings
  PhoneNumberAuthenticationSettings? settings;

  SendPhoneNumberConfirmationCode({
    super.extra,
    super.client_id,
    this.hash,
    this.phone_number,
    this.settings,
  });

  SendPhoneNumberConfirmationCode.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    hash = map['hash'];
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
      'hash': hash?.toMap(skipNulls: skipNulls),
      'phone_number': phone_number?.toMap(skipNulls: skipNulls),
      'settings': settings?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
