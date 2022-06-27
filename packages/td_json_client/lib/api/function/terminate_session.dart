import 'package:td_json_client/api/base.dart';

class TerminateSession extends TdFunction {
  String get tdType => 'terminateSession';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int64? session_id;

  TerminateSession({
    this.extra,
    this.client_id,
    this.session_id,
  });

  TerminateSession.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    session_id = map['session_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'session_id': session_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
