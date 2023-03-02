import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/sticker_type.dart';


/// Changes the order of installed sticker sets 
class ReorderInstalledStickerSets extends TdFunction {
  String get tdType => 'reorderInstalledStickerSets';
  String get tdReturnType => 'Ok';


  /// Type of the sticker sets to reorder 
  StickerType? sticker_type;

  /// Identifiers of installed sticker sets in the new correct order
  vector<int64>? sticker_set_ids;

  ReorderInstalledStickerSets({
    super.extra,
    super.client_id,
    this.sticker_type,
    this.sticker_set_ids,
  });

  ReorderInstalledStickerSets.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sticker_type'] != null) {
      sticker_type = TdApiMap.fromMap(map['sticker_type']) as StickerType;
    }
    if (map['sticker_set_ids'] != null) {
      sticker_set_ids = [];
      for (var someValue in map['sticker_set_ids']) {
        sticker_set_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sticker_type': sticker_type?.toMap(skipNulls: skipNulls),
      'sticker_set_ids': sticker_set_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
