import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/emoji_category.dart';

/// Represents a list of emoji categories
class EmojiCategories extends TdObject {
  String get tdType => 'emojiCategories';

  /// List of categories
  vector<EmojiCategory>? categories;

  EmojiCategories({
    super.extra,
    super.client_id,
    this.categories,
  });

  EmojiCategories.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['categories'] != null) {
      categories = [];
      for (var someValue in map['categories']) {
        if (someValue != null) {
          categories?.add(TdApiMap.fromMap(someValue) as EmojiCategory);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'categories': categories?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
