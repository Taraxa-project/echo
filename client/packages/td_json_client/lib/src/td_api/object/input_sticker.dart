import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/input_file.dart';
import 'package:td_json_client/src/td_api/object/sticker_format.dart';
import 'package:td_json_client/src/td_api/object/mask_position.dart';

/// A sticker to be added to a sticker set
class InputSticker extends TdObject {
  String get tdType => 'inputSticker';

  /// File with the sticker; must fit in a 512x512 square. For WEBP stickers and masks the file must be in PNG format, which will be converted to WEBP server-side.
  /// Otherwise, the file must be local or uploaded within a week. See https://core.telegram.org/animated_stickers#technical-requirements for technical requirements
  InputFile? sticker;

  /// Emojis corresponding to the sticker
  string? emojis;

  /// Sticker format
  StickerFormat? format;

  /// Position where the mask is placed; pass null if not specified
  MaskPosition? mask_position;

  InputSticker({
    super.extra,
    super.client_id,
    this.sticker,
    this.emojis,
    this.format,
    this.mask_position,
  });

  InputSticker.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sticker'] != null) {
      sticker = TdApiMap.fromMap(map['sticker']) as InputFile;
    }
    emojis = map['emojis'];
    if (map['format'] != null) {
      format = TdApiMap.fromMap(map['format']) as StickerFormat;
    }
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
      'format': format?.toMap(skipNulls: skipNulls),
      'mask_position': mask_position?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
