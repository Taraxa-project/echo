import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/background.dart';

/// Contains a list of backgrounds
class Backgrounds extends TdObject {
  String get tdType => 'backgrounds';

  /// A list of backgrounds
  vector<Background>? backgrounds;

  Backgrounds({
    super.extra,
    super.client_id,
    this.backgrounds,
  });

  Backgrounds.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['backgrounds'] != null) {
      backgrounds = [];
      for (var someValue in map['backgrounds']) {
        if (someValue != null) {
          backgrounds?.add(TdApiMap.fromMap(someValue) as Background);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'backgrounds': backgrounds?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
