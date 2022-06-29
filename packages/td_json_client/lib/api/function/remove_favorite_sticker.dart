import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_file.dart';


/// Removes a sticker from the list of favorite stickers 
class RemoveFavoriteSticker extends TdFunction {
  String get tdType => 'removeFavoriteSticker';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Sticker file to delete from the list
  InputFile? sticker;

  RemoveFavoriteSticker({
    this.extra,
    this.client_id,
    this.sticker,
  });

  RemoveFavoriteSticker.fromMap(Map<String, dynamic> map) {
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
