import 'package:td_json_client/api/base.dart';


/// Searches a user by a token from the user's link 
class SearchUserByToken extends TdFunction {
  String get tdType => 'searchUserByToken';
  String get tdReturnType => 'User';


  /// Token to search for
  string? token;

  SearchUserByToken({
    super.extra,
    super.client_id,
    this.token,
  });

  SearchUserByToken.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    token = map['token'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'token': token?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
