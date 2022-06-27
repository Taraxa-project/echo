import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_file.dart';
import 'package:td_json_client/api/object/mask_position.dart';

abstract class InputSticker extends TdObject {}

class InputStickerStatic extends InputSticker {
  String get tdType => 'inputStickerStatic';

  string? extra;
  int? client_id;
  InputFile? sticker;
  string? emojis;
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
    sticker = TdApiMap.fromMap(map['sticker']) as InputFile;
    emojis = map['emojis'];
    mask_position = TdApiMap.fromMap(map['mask_position']) as MaskPosition;
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
class InputStickerAnimated extends InputSticker {
  String get tdType => 'inputStickerAnimated';

  string? extra;
  int? client_id;
  InputFile? sticker;
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
    sticker = TdApiMap.fromMap(map['sticker']) as InputFile;
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
