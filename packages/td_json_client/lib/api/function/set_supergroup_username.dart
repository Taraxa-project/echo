import 'package:td_json_client/api/base.dart';

class SetSupergroupUsername extends TdFunction {
  String get tdType => 'setSupergroupUsername';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int53? supergroup_id;
  string? username;

  SetSupergroupUsername({
    this.extra,
    this.client_id,
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
