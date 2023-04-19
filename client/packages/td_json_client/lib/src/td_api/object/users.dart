import 'package:td_json_client/src/td_api/td.dart';

/// Represents a list of users
class Users extends TdObject {
  String get tdType => 'users';

  /// Approximate total number of users found
  int32? total_count;

  /// A list of user identifiers
  vector<int53>? user_ids;

  Users({
    super.extra,
    super.client_id,
    this.total_count,
    this.user_ids,
  });

  Users.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_count = map['total_count'];
    if (map['user_ids'] != null) {
      user_ids = [];
      for (var someValue in map['user_ids']) {
        user_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'total_count': total_count?.toMap(skipNulls: skipNulls),
      'user_ids': user_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
