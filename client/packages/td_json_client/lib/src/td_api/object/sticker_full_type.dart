import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/file.dart';
import 'package:td_json_client/src/td_api/object/mask_position.dart';

/// Contains full information about sticker type
abstract class StickerFullType extends TdObject {
  StickerFullType({super.extra, super.client_id});
}

/// The sticker is a regular sticker
class StickerFullTypeRegular extends StickerFullType {
  String get tdType => 'stickerFullTypeRegular';

  /// Premium animation of the sticker; may be null. If present, only Telegram Premium users can use the sticker
  File? premium_animation;

  StickerFullTypeRegular({
    super.extra,
    super.client_id,
    this.premium_animation,
  });

  StickerFullTypeRegular.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['premium_animation'] != null) {
      premium_animation = TdApiMap.fromMap(map['premium_animation']) as File;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'premium_animation': premium_animation?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The sticker is a mask in WEBP format to be placed on photos or videos
class StickerFullTypeMask extends StickerFullType {
  String get tdType => 'stickerFullTypeMask';

  /// Position where the mask is placed; may be null
  MaskPosition? mask_position;

  StickerFullTypeMask({
    super.extra,
    super.client_id,
    this.mask_position,
  });

  StickerFullTypeMask.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['mask_position'] != null) {
      mask_position = TdApiMap.fromMap(map['mask_position']) as MaskPosition;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'mask_position': mask_position?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The sticker is a custom emoji to be used inside message text and caption. Currently, only Telegram Premium users can use custom emoji
class StickerFullTypeCustomEmoji extends StickerFullType {
  String get tdType => 'stickerFullTypeCustomEmoji';

  /// Identifier of the custom emoji
  int64? custom_emoji_id;

  /// True, if the sticker must be repainted to a text color in messages, the color of the Telegram Premium badge in emoji status, white color on chat photos, or another appropriate color in other places
  Bool? needs_repainting;

  StickerFullTypeCustomEmoji({
    super.extra,
    super.client_id,
    this.custom_emoji_id,
    this.needs_repainting,
  });

  StickerFullTypeCustomEmoji.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    custom_emoji_id = map['custom_emoji_id'];
    needs_repainting = map['needs_repainting'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'custom_emoji_id': custom_emoji_id?.toMap(skipNulls: skipNulls),
      'needs_repainting': needs_repainting?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
