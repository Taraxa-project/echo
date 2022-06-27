import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_sticker.dart';

class AddStickerToSet extends TdFunction {
  String get tdType => 'addStickerToSet';
  String get tdReturnType => 'StickerSet';

  string? extra;
  int? client_id;
  int53? user_id;
  string? name;
  InputSticker? sticker;

  AddStickerToSet({
    this.extra,
    this.client_id,
    this.user_id,
    this.name,
    this.sticker,
  });

  AddStickerToSet.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    name = map['name'];
    sticker = TdApiMap.fromMap(map['sticker']) as InputSticker;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
      'sticker': sticker?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
