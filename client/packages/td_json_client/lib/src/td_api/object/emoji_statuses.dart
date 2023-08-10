import 'package:td_json_client/src/td_api/td.dart';

/// Contains a list of custom emoji identifiers, which can be set as emoji statuses
class EmojiStatuses extends TdObject {
  String get tdType => 'emojiStatuses';

  /// The list of custom emoji identifiers
  vector<int64>? custom_emoji_ids;

  EmojiStatuses({
    super.extra,
    super.client_id,
    this.custom_emoji_ids,
  });

  EmojiStatuses.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['custom_emoji_ids'] != null) {
      custom_emoji_ids = [];
      for (var someValue in map['custom_emoji_ids']) {
        custom_emoji_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'custom_emoji_ids': custom_emoji_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
