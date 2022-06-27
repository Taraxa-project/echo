import 'package:td_json_client/api/base.dart';

class TemporaryPasswordState extends TdObject {
  String get tdType => 'temporaryPasswordState';

  string? extra;
  int? client_id;
  Bool? has_password;
  int32? valid_for;

  TemporaryPasswordState({
    this.extra,
    this.client_id,
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
