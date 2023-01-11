import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_file.dart';


/// Changes the position of a sticker in the set to which it belongs; for bots only. The sticker set must have been created by the bot
class SetStickerPositionInSet extends TdFunction {
  String get tdType => 'setStickerPositionInSet';
  String get tdReturnType => 'Ok';


  /// Sticker
  InputFile? sticker;

  /// New position of the sticker in the set, 0-based
  int32? position;

  SetStickerPositionInSet({
    super.extra,
    super.client_id,
    this.sticker,
    this.position,
  });

  SetStickerPositionInSet.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sticker'] != null) {
      sticker = TdApiMap.fromMap(map['sticker']) as InputFile;
    }
    position = map['position'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sticker': sticker?.toMap(skipNulls: skipNulls),
      'position': position?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
