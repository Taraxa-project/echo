import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/theme_parameters.dart';

class GetThemeParametersJsonString extends TdFunction {
  String get tdType => 'getThemeParametersJsonString';
  String get tdReturnType => 'Text';

  String? extra;
  int? client_id;
  ThemeParameters? theme;

  GetThemeParametersJsonString({
    this.extra,
    this.client_id,
    this.theme,
  });

  GetThemeParametersJsonString.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    theme = TdApiMap.fromMap(map['theme']) as ThemeParameters;
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
