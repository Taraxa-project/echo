import 'package:td_json_client/api/base.dart';


/// Changes order of active usernames of the current user 
class ReorderActiveUsernames extends TdFunction {
  String get tdType => 'reorderActiveUsernames';
  String get tdReturnType => 'Ok';


  /// The new order of active usernames. All currently active usernames must be specified
  vector<string>? usernames;

  ReorderActiveUsernames({
    super.extra,
    super.client_id,
    this.usernames,
  });

  ReorderActiveUsernames.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
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
      'usernames': usernames?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
