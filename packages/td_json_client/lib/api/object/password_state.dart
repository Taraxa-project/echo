import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/email_address_authentication_code_info.dart';


/// Represents the current state of 2-step verification 
class PasswordState extends TdObject {
  String get tdType => 'passwordState';

  String? extra;
  int? client_id;

  /// True, if a 2-step verification password is set 
  Bool? has_password;

  /// Hint for the password; may be empty
  string? password_hint;

  /// True, if a recovery email is set 
  Bool? has_recovery_email_address;

  /// True, if some Telegram Passport elements were saved
  Bool? has_passport_data;

  /// Information about the recovery email address to which the confirmation email was sent; may be null
  EmailAddressAuthenticationCodeInfo? recovery_email_address_code_info;

  /// If not 0, point in time (Unix timestamp) after which the password can be reset immediately using resetPassword
  int32? pending_reset_date;

  PasswordState({
    this.extra,
    this.client_id,
    this.has_password,
    this.password_hint,
    this.has_recovery_email_address,
    this.has_passport_data,
    this.recovery_email_address_code_info,
    this.pending_reset_date,
  });

  PasswordState.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    has_password = map['has_password'];
    password_hint = map['password_hint'];
    has_recovery_email_address = map['has_recovery_email_address'];
    has_passport_data = map['has_passport_data'];
    if (map['recovery_email_address_code_info'] != null) {
      recovery_email_address_code_info = TdApiMap.fromMap(map['recovery_email_address_code_info']) as EmailAddressAuthenticationCodeInfo;
    }
    pending_reset_date = map['pending_reset_date'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'has_password': has_password?.toMap(skipNulls: skipNulls),
      'password_hint': password_hint?.toMap(skipNulls: skipNulls),
      'has_recovery_email_address': has_recovery_email_address?.toMap(skipNulls: skipNulls),
      'has_passport_data': has_passport_data?.toMap(skipNulls: skipNulls),
      'recovery_email_address_code_info': recovery_email_address_code_info?.toMap(skipNulls: skipNulls),
      'pending_reset_date': pending_reset_date?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
