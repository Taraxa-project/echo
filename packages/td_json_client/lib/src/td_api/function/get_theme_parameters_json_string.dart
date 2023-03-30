import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/theme_parameters.dart';

/// Converts a themeParameters object to corresponding JSON-serialized string. Can be called synchronously
class GetThemeParametersJsonString extends TdFunction {
  String get tdType => 'getThemeParametersJsonString';
  String get tdReturnType => 'Text';

  /// Theme parameters to convert to JSON
  ThemeParameters? theme;

  GetThemeParametersJsonString({
    super.extra,
    super.client_id,
    this.theme,
  });

  GetThemeParametersJsonString.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['theme'] != null) {
      theme = TdApiMap.fromMap(map['theme']) as ThemeParameters;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'theme': theme?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
