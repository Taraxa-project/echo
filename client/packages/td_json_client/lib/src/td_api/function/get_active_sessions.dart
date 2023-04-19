import 'package:td_json_client/src/td_api/td.dart';

/// Returns all active sessions of the current user
class GetActiveSessions extends TdFunction {
  String get tdType => 'getActiveSessions';
  String get tdReturnType => 'Sessions';

  GetActiveSessions({
    super.extra,
    super.client_id,
  });

  GetActiveSessions.fromMap(Map<String, dynamic> map) {
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
