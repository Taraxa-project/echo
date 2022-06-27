import 'package:td_json_client/api/base.dart';

class GetBackgrounds extends TdFunction {
  String get tdType => 'getBackgrounds';
  String get tdReturnType => 'Backgrounds';

  string? extra;
  int? client_id;
  Bool? for_dark_theme;

  GetBackgrounds({
    this.extra,
    this.client_id,
    this.for_dark_theme,
  });

  GetBackgrounds.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    for_dark_theme = map['for_dark_theme'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'for_dark_theme': for_dark_theme?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
