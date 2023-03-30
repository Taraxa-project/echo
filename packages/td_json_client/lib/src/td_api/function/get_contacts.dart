import 'package:td_json_client/src/td_api/td.dart';

/// Returns all user contacts
class GetContacts extends TdFunction {
  String get tdType => 'getContacts';
  String get tdReturnType => 'Users';

  GetContacts({
    super.extra,
    super.client_id,
  });

  GetContacts.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
