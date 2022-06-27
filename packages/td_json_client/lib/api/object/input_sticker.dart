import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_file.dart';
import 'package:td_json_client/api/object/sticker_type.dart';

class InputSticker extends TdObject {
  String get tdType => 'inputSticker';

  String? extra;
  int? client_id;
  InputFile? sticker;
  string? emojis;
  StickerType? type;

  InputSticker({
    this.extra,
    this.client_id,
    this.sticker,
    this.emojis,
    this.type,
  });

  InputSticker.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    sticker = TdApiMap.fromMap(map['sticker']) as InputFile;
    emojis = map['emojis'];
    type = TdApiMap.fromMap(map['type']) as StickerType;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sticker': sticker?.toMap(skipNulls: skipNulls),
      'emojis': emojis?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
