import 'package:td_json_client/src/td_api/td.dart';

/// Returns all active live locations that need to be updated by the application. The list is persistent across application restarts only if the message database is used
class GetActiveLiveLocationMessages extends TdFunction {
  String get tdType => 'getActiveLiveLocationMessages';
  String get tdReturnType => 'Messages';

  GetActiveLiveLocationMessages({
    super.extra,
    super.client_id,
  });

  GetActiveLiveLocationMessages.fromMap(Map<String, dynamic> map) {
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
