import 'package:td_json_client/src/td_api/td.dart';

/// Clears the list of all autosave settings exceptions. The method is guaranteed to work only after at least one call to getAutosaveSettings
class ClearAutosaveSettingsExceptions extends TdFunction {
  String get tdType => 'clearAutosaveSettingsExceptions';
  String get tdReturnType => 'Ok';

  ClearAutosaveSettingsExceptions({
    super.extra,
    super.client_id,
  });

  ClearAutosaveSettingsExceptions.fromMap(Map<String, dynamic> map) {
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
