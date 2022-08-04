import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/mask_position.dart';

/// Describes type of a sticker
abstract class StickerType extends TdObject {
  StickerType({super.extra, super.client_id});
}


/// The sticker is an image in WEBP format
class StickerTypeStatic extends StickerType {
  String get tdType => 'stickerTypeStatic';


  StickerTypeStatic({
    super.extra,
    super.client_id,
  });

  StickerTypeStatic.fromMap(Map<String, dynamic> map) {
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

/// The sticker is an animation in TGS format
class StickerTypeAnimated extends StickerType {
  String get tdType => 'stickerTypeAnimated';


  StickerTypeAnimated({
    super.extra,
    super.client_id,
  });

  StickerTypeAnimated.fromMap(Map<String, dynamic> map) {
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

/// The sticker is a video in WEBM format
class StickerTypeVideo extends StickerType {
  String get tdType => 'stickerTypeVideo';


  StickerTypeVideo({
    super.extra,
    super.client_id,
  });

  StickerTypeVideo.fromMap(Map<String, dynamic> map) {
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


  /// Position where the mask is placed; may be null
  MaskPosition? mask_position;

  StickerTypeMask({
    super.extra,
    super.client_id,
    this.mask_position,
  });

  StickerTypeMask.fromMap(Map<String, dynamic> map) {
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
