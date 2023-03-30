import 'package:td_json_client/src/td_api/td.dart';

/// Returns information about the current temporary password
class GetTemporaryPasswordState extends TdFunction {
  String get tdType => 'getTemporaryPasswordState';
  String get tdReturnType => 'TemporaryPasswordState';

  GetTemporaryPasswordState({
    super.extra,
    super.client_id,
  });

  GetTemporaryPasswordState.fromMap(Map<String, dynamic> map) {
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
