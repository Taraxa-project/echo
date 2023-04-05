import 'package:td_json_client/src/td_api/td.dart';

/// Cancels reset of 2-step verification password. The method can be called if passwordState.pending_reset_date > 0
class CancelPasswordReset extends TdFunction {
  String get tdType => 'cancelPasswordReset';
  String get tdReturnType => 'Ok';

  CancelPasswordReset({
    super.extra,
    super.client_id,
  });

  CancelPasswordReset.fromMap(Map<String, dynamic> map) {
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
