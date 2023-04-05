import 'package:td_json_client/src/td_api/td.dart';

/// Returns all website where the current user used Telegram to log in
class GetConnectedWebsites extends TdFunction {
  String get tdType => 'getConnectedWebsites';
  String get tdReturnType => 'ConnectedWebsites';

  GetConnectedWebsites({
    super.extra,
    super.client_id,
  });

  GetConnectedWebsites.fromMap(Map<String, dynamic> map) {
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
