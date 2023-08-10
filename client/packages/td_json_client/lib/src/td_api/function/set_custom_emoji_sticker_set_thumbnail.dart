import 'package:td_json_client/src/td_api/td.dart';

/// Sets a custom emoji sticker set thumbnail; for bots only
class SetCustomEmojiStickerSetThumbnail extends TdFunction {
  String get tdType => 'setCustomEmojiStickerSetThumbnail';
  String get tdReturnType => 'Ok';

  /// Sticker set name
  string? name;

  /// Identifier of the custom emoji from the sticker set, which will be set as sticker set thumbnail; pass 0 to remove the sticker set thumbnail
  int64? custom_emoji_id;

  SetCustomEmojiStickerSetThumbnail({
    super.extra,
    super.client_id,
    this.name,
    this.custom_emoji_id,
  });

  SetCustomEmojiStickerSetThumbnail.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    name = map['name'];
    custom_emoji_id = map['custom_emoji_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
      'custom_emoji_id': custom_emoji_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
