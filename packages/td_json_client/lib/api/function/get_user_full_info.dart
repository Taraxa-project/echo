import 'package:td_json_client/api/base.dart';

class GetUserFullInfo extends TdFunction {
  String get tdType => 'getUserFullInfo';
  String get tdReturnType => 'UserFullInfo';

  string? extra;
  int? client_id;
  int53? user_id;

  GetUserFullInfo({
    this.extra,
    this.client_id,
    this.user_id,
  });

  GetUserFullInfo.fromMap(Map<String, dynamic> map) {
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