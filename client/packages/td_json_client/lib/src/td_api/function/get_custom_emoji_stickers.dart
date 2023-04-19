import 'package:td_json_client/src/td_api/td.dart';

/// Returns list of custom emoji stickers by their identifiers. Stickers are returned in arbitrary order. Only found stickers are returned
class GetCustomEmojiStickers extends TdFunction {
  String get tdType => 'getCustomEmojiStickers';
  String get tdReturnType => 'Stickers';

  /// Identifiers of custom emoji stickers. At most 200 custom emoji stickers can be received simultaneously
  vector<int64>? custom_emoji_ids;

  GetCustomEmojiStickers({
    super.extra,
    super.client_id,
    this.custom_emoji_ids,
  });

  GetCustomEmojiStickers.fromMap(Map<String, dynamic> map) {
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
