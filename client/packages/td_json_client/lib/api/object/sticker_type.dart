import 'package:td_json_client/api/base.dart';

/// Describes type of a sticker
abstract class StickerType extends TdObject {
  StickerType({super.extra, super.client_id});
}


/// The sticker is a regular sticker
class StickerTypeRegular extends StickerType {
  String get tdType => 'stickerTypeRegular';


  StickerTypeRegular({
    super.extra,
    super.client_id,
  });

  StickerTypeRegular.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The sticker is a mask in WEBP format to be placed on photos or videos
class StickerTypeMask extends StickerType {
  String get tdType => 'stickerTypeMask';


  StickerTypeMask({
    super.extra,
    super.client_id,
  });

  StickerTypeMask.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The sticker is a custom emoji to be used inside message text and caption
class StickerTypeCustomEmoji extends StickerType {
  String get tdType => 'stickerTypeCustomEmoji';


  StickerTypeCustomEmoji({
    super.extra,
    super.client_id,
  });

  StickerTypeCustomEmoji.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
