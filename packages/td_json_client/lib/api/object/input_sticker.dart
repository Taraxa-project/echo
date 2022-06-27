import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_file.dart';
import 'package:td_json_client/api/object/sticker_type.dart';


/// A sticker to be added to a sticker set
class InputSticker extends TdObject {
  String get tdType => 'inputSticker';

  String? extra;
  int? client_id;

  /// File with the sticker; must fit in a 512x512 square. For WEBP stickers and masks the file must be in PNG format, which will be converted to WEBP server-side. Otherwise, the file must be local or uploaded within a week. See https://core.telegram.org/animated_stickers#technical-requirements for technical requirements
  InputFile? sticker;

  /// Emojis corresponding to the sticker
  string? emojis;

  /// Sticker type
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
