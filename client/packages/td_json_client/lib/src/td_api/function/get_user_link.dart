import 'package:td_json_client/src/td_api/td.dart';

/// Returns an HTTPS link, which can be used to get information about the current user
class GetUserLink extends TdFunction {
  String get tdType => 'getUserLink';
  String get tdReturnType => 'UserLink';

  GetUserLink({
    super.extra,
    super.client_id,
  });

  GetUserLink.fromMap(Map<String, dynamic> map) {
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
