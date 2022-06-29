import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_file.dart';
import 'package:td_json_client/api/object/mask_position.dart';

/// Describes a sticker that needs to be added to a sticker set
abstract class InputSticker extends TdObject {}


/// A static sticker in PNG format, which will be converted to WEBP server-side
class InputStickerStatic extends InputSticker {
  String get tdType => 'inputStickerStatic';

  String? extra;
  int? client_id;

  /// PNG image with the sticker; must be up to 512 KB in size and fit in a 512x512 square
  InputFile? sticker;

  /// Emojis corresponding to the sticker
  string? emojis;

  /// For masks, position where the mask is placed; pass null if unspecified
  MaskPosition? mask_position;

  InputStickerStatic({
    this.extra,
    this.client_id,
    this.sticker,
    this.emojis,
    this.mask_position,
  });

  InputStickerStatic.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sticker'] != null) {
      sticker = TdApiMap.fromMap(map['sticker']) as InputFile;
    }
    emojis = map['emojis'];
    if (map['mask_position'] != null) {
      mask_position = TdApiMap.fromMap(map['mask_position']) as MaskPosition;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sticker': sticker?.toMap(skipNulls: skipNulls),
      'emojis': emojis?.toMap(skipNulls: skipNulls),
      'mask_position': mask_position?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// An animated sticker in TGS format
class InputStickerAnimated extends InputSticker {
  String get tdType => 'inputStickerAnimated';

  String? extra;
  int? client_id;

  /// File with the animated sticker. Only local or uploaded within a week files are supported. See https://core.telegram.org/animated_stickers#technical-requirements for technical requirements
  InputFile? sticker;

  /// Emojis corresponding to the sticker
  string? emojis;

  InputStickerAnimated({
    this.extra,
    this.client_id,
    this.sticker,
    this.emojis,
  });

  InputStickerAnimated.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sticker'] != null) {
      sticker = TdApiMap.fromMap(map['sticker']) as InputFile;
    }
    emojis = map['emojis'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sticker': sticker?.toMap(skipNulls: skipNulls),
      'emojis': emojis?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
