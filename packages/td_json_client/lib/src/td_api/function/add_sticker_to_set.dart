import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/input_sticker.dart';

/// Adds a new sticker to a set; for bots only. Returns the sticker set
class AddStickerToSet extends TdFunction {
  String get tdType => 'addStickerToSet';
  String get tdReturnType => 'StickerSet';

  /// Sticker set owner
  int53? user_id;

  /// Sticker set name
  string? name;

  /// Sticker to add to the set
  InputSticker? sticker;

  AddStickerToSet({
    super.extra,
    super.client_id,
    this.user_id,
    this.name,
    this.sticker,
  });

  AddStickerToSet.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    name = map['name'];
    if (map['sticker'] != null) {
      sticker = TdApiMap.fromMap(map['sticker']) as InputSticker;
    }
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
