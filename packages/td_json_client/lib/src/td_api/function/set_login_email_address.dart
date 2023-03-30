import 'package:td_json_client/src/td_api/td.dart';

/// Changes the login email address of the user. The change will not be applied until the new login email address is confirmed with checkLoginEmailAddressCode.
/// To use Apple ID/Google ID instead of a email address, call checkLoginEmailAddressCode directly
class SetLoginEmailAddress extends TdFunction {
  String get tdType => 'setLoginEmailAddress';
  String get tdReturnType => 'EmailAddressAuthenticationCodeInfo';

  /// New login email address
  string? new_login_email_address;

  SetLoginEmailAddress({
    super.extra,
    super.client_id,
    this.new_login_email_address,
  });

  SetLoginEmailAddress.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    new_login_email_address = map['new_login_email_address'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'new_login_email_address':
          new_login_email_address?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
