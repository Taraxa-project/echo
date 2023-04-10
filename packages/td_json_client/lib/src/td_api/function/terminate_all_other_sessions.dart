import 'package:td_json_client/src/td_api/td.dart';

/// Terminates all other sessions of the current user
class TerminateAllOtherSessions extends TdFunction {
  String get tdType => 'terminateAllOtherSessions';
  String get tdReturnType => 'Ok';

  TerminateAllOtherSessions({
    super.extra,
    super.client_id,
  });

  TerminateAllOtherSessions.fromMap(Map<String, dynamic> map) {
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
