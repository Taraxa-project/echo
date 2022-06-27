import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/mask_position.dart';

abstract class StickerType extends TdObject {}

class StickerTypeStatic extends StickerType {
  String get tdType => 'stickerTypeStatic';

  string? extra;
  int? client_id;

  StickerTypeStatic({
    this.extra,
    this.client_id,
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
class StickerTypeAnimated extends StickerType {
  String get tdType => 'stickerTypeAnimated';

  string? extra;
  int? client_id;

  StickerTypeAnimated({
    this.extra,
    this.client_id,
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
class StickerTypeVideo extends StickerType {
  String get tdType => 'stickerTypeVideo';

  string? extra;
  int? client_id;

  StickerTypeVideo({
    this.extra,
    this.client_id,
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
class StickerTypeMask extends StickerType {
  String get tdType => 'stickerTypeMask';

  string? extra;
  int? client_id;
  MaskPosition? mask_position;

  StickerTypeMask({
    this.extra,
    this.client_id,
    this.mask_position,
  });

  StickerTypeMask.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    mask_position = TdApiMap.fromMap(map['mask_position']) as MaskPosition;
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
