import 'package:td_json_client/src/td_api/td.dart';

/// Describes type of a sticker, which was used to create a chat photo
abstract class ChatPhotoStickerType extends TdObject {
  ChatPhotoStickerType({super.extra, super.client_id});
}

/// Information about the sticker, which was used to create the chat photo
class ChatPhotoStickerTypeRegularOrMask extends ChatPhotoStickerType {
  String get tdType => 'chatPhotoStickerTypeRegularOrMask';

  /// Sticker set identifier
  int64? sticker_set_id;

  /// Identifier of the sticker in the set
  int64? sticker_id;

  ChatPhotoStickerTypeRegularOrMask({
    super.extra,
    super.client_id,
    this.sticker_set_id,
    this.sticker_id,
  });

  ChatPhotoStickerTypeRegularOrMask.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    sticker_set_id = map['sticker_set_id'];
    sticker_id = map['sticker_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sticker_set_id': sticker_set_id?.toMap(skipNulls: skipNulls),
      'sticker_id': sticker_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Information about the custom emoji, which was used to create the chat photo
class ChatPhotoStickerTypeCustomEmoji extends ChatPhotoStickerType {
  String get tdType => 'chatPhotoStickerTypeCustomEmoji';

  /// Identifier of the custom emoji
  int64? custom_emoji_id;

  ChatPhotoStickerTypeCustomEmoji({
    super.extra,
    super.client_id,
    this.custom_emoji_id,
  });

  ChatPhotoStickerTypeCustomEmoji.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    custom_emoji_id = map['custom_emoji_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'custom_emoji_id': custom_emoji_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
