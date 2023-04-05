import 'package:td_json_client/src/td_api/td.dart';

/// Creates a new temporary password for processing payments
class CreateTemporaryPassword extends TdFunction {
  String get tdType => 'createTemporaryPassword';
  String get tdReturnType => 'TemporaryPasswordState';

  /// The 2-step verification password of the current user
  string? password;

  /// Time during which the temporary password will be valid, in seconds; must be between 60 and 86400
  int32? valid_for;

  CreateTemporaryPassword({
    super.extra,
    super.client_id,
    this.password,
    this.valid_for,
  });

  CreateTemporaryPassword.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    password = map['password'];
    valid_for = map['valid_for'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'password': password?.toMap(skipNulls: skipNulls),
      'valid_for': valid_for?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
