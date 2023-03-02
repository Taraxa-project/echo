import 'package:td_json_client/api/base.dart';


/// Returns support information for the given user; for Telegram support only 
class GetUserSupportInfo extends TdFunction {
  String get tdType => 'getUserSupportInfo';
  String get tdReturnType => 'UserSupportInfo';


  /// User identifier
  int53? user_id;

  GetUserSupportInfo({
    super.extra,
    super.client_id,
    this.user_id,
  });

  GetUserSupportInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
