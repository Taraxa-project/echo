import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/input_file.dart';

/// Adds a new sticker to the list of favorite stickers. The new sticker is added to the top of the list. If the sticker was already in the list, it is removed from the list first.
/// Only stickers belonging to a sticker set can be added to this list. Emoji stickers can't be added to favorite stickers
class AddFavoriteSticker extends TdFunction {
  String get tdType => 'addFavoriteSticker';
  String get tdReturnType => 'Ok';

  /// Sticker file to add
  InputFile? sticker;

  AddFavoriteSticker({
    super.extra,
    super.client_id,
    this.sticker,
  });

  AddFavoriteSticker.fromMap(Map<String, dynamic> map) {
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
