import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/background.dart';

class Backgrounds extends TdObject {
  String get tdType => 'backgrounds';

  string? extra;
  int? client_id;
  vector<Background>? backgrounds;

  Backgrounds({
    this.extra,
    this.client_id,
    this.backgrounds,
  });

  Backgrounds.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['backgrounds']) {
      backgrounds = [];
      for (var someValue in map['backgrounds']) {
        backgrounds?.add(TdApiMap.fromMap(someValue) as Background);
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
