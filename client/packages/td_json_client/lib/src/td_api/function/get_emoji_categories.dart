import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/emoji_category_type.dart';

/// Returns available emojis categories
class GetEmojiCategories extends TdFunction {
  String get tdType => 'getEmojiCategories';
  String get tdReturnType => 'EmojiCategories';

  /// Type of emoji categories to return; pass null to get default emoji categories
  EmojiCategoryType? type;

  GetEmojiCategories({
    super.extra,
    super.client_id,
    this.type,
  });

  GetEmojiCategories.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as EmojiCategoryType;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
