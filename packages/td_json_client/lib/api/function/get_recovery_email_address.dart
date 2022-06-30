import 'package:td_json_client/api/base.dart';


/// Returns a 2-step verification recovery email address that was previously set up. This method can be used to verify a password provided by the user 
class GetRecoveryEmailAddress extends TdFunction {
  String get tdType => 'getRecoveryEmailAddress';
  String get tdReturnType => 'RecoveryEmailAddress';


  /// The password for the current user
  string? password;

  GetRecoveryEmailAddress({
    super.extra,
    super.client_id,
    this.password,
  });

  GetRecoveryEmailAddress.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    password = map['password'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'password': password?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
