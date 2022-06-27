import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/animation.dart';

class Animations extends TdObject {
  String get tdType => 'animations';

  string? extra;
  int? client_id;
  vector<Animation>? animations;

  Animations({
    this.extra,
    this.client_id,
    this.animations,
  });

  Animations.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['animations']) {
      animations = [];
      for (var someValue in map['animations']) {
        animations?.add(TdApiMap.fromMap(someValue) as Animation);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'animations': animations?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
