import 'package:td_json_client/src/td_api/td.dart';

/// Returns the current state of 2-step verification
class GetPasswordState extends TdFunction {
  String get tdType => 'getPasswordState';
  String get tdReturnType => 'PasswordState';

  GetPasswordState({
    super.extra,
    super.client_id,
  });

  GetPasswordState.fromMap(Map<String, dynamic> map) {
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
