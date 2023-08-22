import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/sticker.dart';

/// Contains a list of similar emoji to search for in getStickers and searchStickers
class EmojiCategory extends TdObject {
  String get tdType => 'emojiCategory';

  /// Name of the category
  string? name;

  /// Custom emoji sticker, which represents icon of the category
  Sticker? icon;

  /// List of emojis in the category
  vector<string>? emojis;

  EmojiCategory({
    super.extra,
    super.client_id,
    this.name,
    this.icon,
    this.emojis,
  });

  EmojiCategory.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    name = map['name'];
    if (map['icon'] != null) {
      icon = TdApiMap.fromMap(map['icon']) as Sticker;
    }
    if (map['emojis'] != null) {
      emojis = [];
      for (var someValue in map['emojis']) {
        emojis?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
      'icon': icon?.toMap(skipNulls: skipNulls),
      'emojis': emojis?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
