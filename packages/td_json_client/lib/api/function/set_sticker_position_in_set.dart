import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_file.dart';

class SetStickerPositionInSet extends TdFunction {
  String get tdType => 'setStickerPositionInSet';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  InputFile? sticker;
  int32? position;

  SetStickerPositionInSet({
    this.extra,
    this.client_id,
    this.sticker,
    this.position,
  });

  SetStickerPositionInSet.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    sticker = TdApiMap.fromMap(map['sticker']) as InputFile;
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
