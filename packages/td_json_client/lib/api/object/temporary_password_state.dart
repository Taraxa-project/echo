import 'package:td_json_client/api/base.dart';


/// Returns information about the availability of a temporary password, which can be used for payments 
class TemporaryPasswordState extends TdObject {
  String get tdType => 'temporaryPasswordState';


  /// True, if a temporary password is available 
  Bool? has_password;

  /// Time left before the temporary password expires, in seconds
  int32? valid_for;

  TemporaryPasswordState({
    super.extra,
    super.client_id,
    this.has_password,
    this.valid_for,
  });

  TemporaryPasswordState.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    has_password = map['has_password'];
    valid_for = map['valid_for'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'has_password': has_password?.toMap(skipNulls: skipNulls),
      'valid_for': valid_for?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
