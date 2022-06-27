import 'package:td_json_client/api/base.dart';

class ToggleSessionCanAcceptCalls extends TdFunction {
  String get tdType => 'toggleSessionCanAcceptCalls';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  int64? session_id;
  Bool? can_accept_calls;

  ToggleSessionCanAcceptCalls({
    this.extra,
    this.client_id,
    this.session_id,
    this.can_accept_calls,
  });

  ToggleSessionCanAcceptCalls.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    session_id = map['session_id'];
    can_accept_calls = map['can_accept_calls'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'session_id': session_id?.toMap(skipNulls: skipNulls),
      'can_accept_calls': can_accept_calls?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
