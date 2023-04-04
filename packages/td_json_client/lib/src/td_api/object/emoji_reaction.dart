import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/sticker.dart';

/// Contains information about a emoji reaction
class EmojiReaction extends TdObject {
  String get tdType => 'emojiReaction';

  /// Text representation of the reaction
  string? emoji;

  /// Reaction title
  string? title;

  /// True, if the reaction can be added to new messages and enabled in chats
  Bool? is_active;

  /// Static icon for the reaction
  Sticker? static_icon;

  /// Appear animation for the reaction
  Sticker? appear_animation;

  /// Select animation for the reaction
  Sticker? select_animation;

  /// Activate animation for the reaction
  Sticker? activate_animation;

  /// Effect animation for the reaction
  Sticker? effect_animation;

  /// Around animation for the reaction; may be null
  Sticker? around_animation;

  /// Center animation for the reaction; may be null
  Sticker? center_animation;

  EmojiReaction({
    super.extra,
    super.client_id,
    this.emoji,
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

  EmojiReaction.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    emoji = map['emoji'];
    title = map['title'];
    is_active = map['is_active'];
    if (map['static_icon'] != null) {
      static_icon = TdApiMap.fromMap(map['static_icon']) as Sticker;
    }
    if (map['appear_animation'] != null) {
      appear_animation = TdApiMap.fromMap(map['appear_animation']) as Sticker;
    }
    if (map['select_animation'] != null) {
      select_animation = TdApiMap.fromMap(map['select_animation']) as Sticker;
    }
    if (map['activate_animation'] != null) {
      activate_animation = TdApiMap.fromMap(map['activate_animation']) as Sticker;
    }
    if (map['effect_animation'] != null) {
      effect_animation = TdApiMap.fromMap(map['effect_animation']) as Sticker;
    }
    if (map['around_animation'] != null) {
      around_animation = TdApiMap.fromMap(map['around_animation']) as Sticker;
    }
    if (map['center_animation'] != null) {
      center_animation = TdApiMap.fromMap(map['center_animation']) as Sticker;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'emoji': emoji?.toMap(skipNulls: skipNulls),
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
