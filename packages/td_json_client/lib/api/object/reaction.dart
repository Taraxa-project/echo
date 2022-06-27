import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/sticker.dart';

class Reaction extends TdObject {
  String get tdType => 'reaction';

  String? extra;
  int? client_id;
  string? reaction;
  string? title;
  Bool? is_active;
  Sticker? static_icon;
  Sticker? appear_animation;
  Sticker? select_animation;
  Sticker? activate_animation;
  Sticker? effect_animation;
  Sticker? around_animation;
  Sticker? center_animation;

  Reaction({
    this.extra,
    this.client_id,
    this.reaction,
    this.title,
    this.is_active,
    this.static_icon,
    this.appear_animation,
    this.select_animation,
    this.activate_animation,
    this.effect_animation,
    this.around_animation,
    this.center_animation,
  });

  Reaction.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    reaction = map['reaction'];
    title = map['title'];
    is_active = map['is_active'];
    static_icon = TdApiMap.fromMap(map['static_icon']) as Sticker;
    appear_animation = TdApiMap.fromMap(map['appear_animation']) as Sticker;
    select_animation = TdApiMap.fromMap(map['select_animation']) as Sticker;
    activate_animation = TdApiMap.fromMap(map['activate_animation']) as Sticker;
    effect_animation = TdApiMap.fromMap(map['effect_animation']) as Sticker;
    around_animation = TdApiMap.fromMap(map['around_animation']) as Sticker;
    center_animation = TdApiMap.fromMap(map['center_animation']) as Sticker;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'reaction': reaction?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'is_active': is_active?.toMap(skipNulls: skipNulls),
      'static_icon': static_icon?.toMap(skipNulls: skipNulls),
      'appear_animation': appear_animation?.toMap(skipNulls: skipNulls),
      'select_animation': select_animation?.toMap(skipNulls: skipNulls),
      'activate_animation': activate_animation?.toMap(skipNulls: skipNulls),
      'effect_animation': effect_animation?.toMap(skipNulls: skipNulls),
      'around_animation': around_animation?.toMap(skipNulls: skipNulls),
      'center_animation': center_animation?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
