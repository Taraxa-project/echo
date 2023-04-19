import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/input_file.dart';

/// Removes a sticker from the set to which it belongs; for bots only. The sticker set must have been created by the bot
class RemoveStickerFromSet extends TdFunction {
  String get tdType => 'removeStickerFromSet';
  String get tdReturnType => 'Ok';

  /// Sticker
  InputFile? sticker;

  RemoveStickerFromSet({
    super.extra,
    super.client_id,
    this.sticker,
  });

  RemoveStickerFromSet.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sticker'] != null) {
      sticker = TdApiMap.fromMap(map['sticker']) as InputFile;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sticker': sticker?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
