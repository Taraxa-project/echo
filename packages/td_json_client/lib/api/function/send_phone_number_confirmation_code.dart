import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/phone_number_authentication_settings.dart';

class SendPhoneNumberConfirmationCode extends TdFunction {
  String get tdType => 'sendPhoneNumberConfirmationCode';
  String get tdReturnType => 'AuthenticationCodeInfo';

  String? extra;
  int? client_id;
  string? hash;
  string? phone_number;
  PhoneNumberAuthenticationSettings? settings;

  SendPhoneNumberConfirmationCode({
    this.extra,
    this.client_id,
    this.hash,
    this.phone_number,
    this.settings,
  });

  SendPhoneNumberConfirmationCode.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    hash = map['hash'];
    phone_number = map['phone_number'];
    settings = TdApiMap.fromMap(map['settings']) as PhoneNumberAuthenticationSettings;
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
