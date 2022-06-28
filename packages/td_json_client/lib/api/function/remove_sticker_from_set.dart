import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_file.dart';


/// Removes a sticker from the set to which it belongs; for bots only. The sticker set must have been created by the bot 
class RemoveStickerFromSet extends TdFunction {
  String get tdType => 'removeStickerFromSet';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Sticker
  InputFile? sticker;

  RemoveStickerFromSet({
    this.extra,
    this.client_id,
    this.sticker,
  });

  RemoveStickerFromSet.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    sticker = TdApiMap.fromMap(map['sticker']) as InputFile;
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
