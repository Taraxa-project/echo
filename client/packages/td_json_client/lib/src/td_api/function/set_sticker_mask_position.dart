import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/input_file.dart';
import 'package:td_json_client/src/td_api/object/mask_position.dart';

/// Changes the mask position of a mask sticker; for bots only. The sticker must belong to a mask sticker set created by the bot
class SetStickerMaskPosition extends TdFunction {
  String get tdType => 'setStickerMaskPosition';
  String get tdReturnType => 'Ok';

  /// Sticker
  InputFile? sticker;

  /// Position where the mask is placed; pass null to remove mask position
  MaskPosition? mask_position;

  SetStickerMaskPosition({
    super.extra,
    super.client_id,
    this.sticker,
    this.mask_position,
  });

  SetStickerMaskPosition.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sticker'] != null) {
      sticker = TdApiMap.fromMap(map['sticker']) as InputFile;
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
      'mask_position': mask_position?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
