import 'package:td_json_client/api/base.dart';

/// Changes the editable username of the current user
class SetUsername extends TdFunction {
  String get tdType => 'setUsername';
  String get tdReturnType => 'Ok';

  /// The new value of the username. Use an empty string to remove the username. The username can't be completely removed if there is another active or disabled username
  string? username;

  SetUsername({
    super.extra,
    super.client_id,
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
