import 'package:td_json_client/api/base.dart';

class SetUsername extends TdFunction {
  String get tdType => 'setUsername';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  string? username;

  SetUsername({
    this.extra,
    this.client_id,
    this.username,
  });

  SetUsername.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    username = map['username'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'username': username?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
