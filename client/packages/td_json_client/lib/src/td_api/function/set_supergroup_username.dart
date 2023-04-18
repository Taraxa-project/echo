import 'package:td_json_client/src/td_api/td.dart';

/// Changes the editable username of a supergroup or channel, requires owner privileges in the supergroup or channel
class SetSupergroupUsername extends TdFunction {
  String get tdType => 'setSupergroupUsername';
  String get tdReturnType => 'Ok';

  /// Identifier of the supergroup or channel
  int53? supergroup_id;

  /// New value of the username. Use an empty string to remove the username. The username can't be completely removed if there is another active or disabled username
  string? username;

  SetSupergroupUsername({
    super.extra,
    super.client_id,
    this.supergroup_id,
    this.username,
  });

  SetSupergroupUsername.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    supergroup_id = map['supergroup_id'];
    username = map['username'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'supergroup_id': supergroup_id?.toMap(skipNulls: skipNulls),
      'username': username?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
