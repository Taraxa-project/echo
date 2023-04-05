import 'package:td_json_client/src/td_api/td.dart';

/// Searches a user by their phone number. Returns a 404 error if the user can't be found
class SearchUserByPhoneNumber extends TdFunction {
  String get tdType => 'searchUserByPhoneNumber';
  String get tdReturnType => 'User';

  /// Phone number to search for
  string? phone_number;

  SearchUserByPhoneNumber({
    super.extra,
    super.client_id,
    this.phone_number,
  });

  SearchUserByPhoneNumber.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    phone_number = map['phone_number'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'phone_number': phone_number?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
