import 'package:td_json_client/api/base.dart';


/// Removes users from the contact list 
class RemoveContacts extends TdFunction {
  String get tdType => 'removeContacts';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Identifiers of users to be deleted
  vector<int53>? user_ids;

  RemoveContacts({
    this.extra,
    this.client_id,
    this.user_ids,
  });

  RemoveContacts.fromMap(Map<String, dynamic> map) {
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
