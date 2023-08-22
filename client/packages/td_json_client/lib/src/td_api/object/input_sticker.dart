import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/input_file.dart';
import 'package:td_json_client/src/td_api/object/mask_position.dart';

/// A sticker to be added to a sticker set
class InputSticker extends TdObject {
  String get tdType => 'inputSticker';

  /// File with the sticker; must fit in a 512x512 square. For WEBP stickers the file must be in WEBP or PNG format, which will be converted to WEBP server-side.
  /// See https://core.telegram.org/animated_stickers#technical-requirements for technical requirements
  InputFile? sticker;

  /// String with 1-20 emoji corresponding to the sticker
  string? emojis;

  /// Position where the mask is placed; pass null if not specified
  MaskPosition? mask_position;

  /// List of up to 20 keywords with total length up to 64 characters, which can be used to find the sticker
  vector<string>? keywords;

  InputSticker({
    super.extra,
    super.client_id,
    this.sticker,
    this.emojis,
    this.mask_position,
    this.keywords,
  });

  InputSticker.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sticker'] != null) {
      sticker = TdApiMap.fromMap(map['sticker']) as InputFile;
    }
    emojis = map['emojis'];
    if (map['mask_position'] != null) {
      mask_position = TdApiMap.fromMap(map['mask_position']) as MaskPosition;
    }
    if (map['keywords'] != null) {
      keywords = [];
      for (var someValue in map['keywords']) {
        keywords?.add(someValue);
      }
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
      'keywords': keywords?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
