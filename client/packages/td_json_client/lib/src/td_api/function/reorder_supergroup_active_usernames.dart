import 'package:td_json_client/src/td_api/td.dart';

/// Changes order of active usernames of a supergroup or channel, requires owner privileges in the supergroup or channel
class ReorderSupergroupActiveUsernames extends TdFunction {
  String get tdType => 'reorderSupergroupActiveUsernames';
  String get tdReturnType => 'Ok';

  /// Identifier of the supergroup or channel
  int53? supergroup_id;

  /// The new order of active usernames. All currently active usernames must be specified
  vector<string>? usernames;

  ReorderSupergroupActiveUsernames({
    super.extra,
    super.client_id,
    this.supergroup_id,
    this.usernames,
  });

  ReorderSupergroupActiveUsernames.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    supergroup_id = map['supergroup_id'];
    if (map['usernames'] != null) {
      usernames = [];
      for (var someValue in map['usernames']) {
        usernames?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'supergroup_id': supergroup_id?.toMap(skipNulls: skipNulls),
      'usernames': usernames?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
