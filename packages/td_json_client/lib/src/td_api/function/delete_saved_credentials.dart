import 'package:td_json_client/src/td_api/td.dart';

/// Deletes saved credentials for all payment provider bots
class DeleteSavedCredentials extends TdFunction {
  String get tdType => 'deleteSavedCredentials';
  String get tdReturnType => 'Ok';

  DeleteSavedCredentials({
    super.extra,
    super.client_id,
  });

  DeleteSavedCredentials.fromMap(Map<String, dynamic> map) {
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
