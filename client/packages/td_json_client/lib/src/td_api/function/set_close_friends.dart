import 'package:td_json_client/src/td_api/td.dart';

/// Changes the list of close friends of the current user
class SetCloseFriends extends TdFunction {
  String get tdType => 'setCloseFriends';
  String get tdReturnType => 'Ok';

  /// User identifiers of close friends; the users must be contacts of the current user
  vector<int53>? user_ids;

  SetCloseFriends({
    super.extra,
    super.client_id,
    this.user_ids,
  });

  SetCloseFriends.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
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
      'user_ids': user_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
