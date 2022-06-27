import 'package:td_json_client/api/base.dart';


/// Changes the order of installed sticker sets 
class ReorderInstalledStickerSets extends TdFunction {
  String get tdType => 'reorderInstalledStickerSets';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Pass true to change the order of mask sticker sets; pass false to change the order of ordinary sticker sets 
  Bool? is_masks;

  /// Identifiers of installed sticker sets in the new correct order
  vector<int64>? sticker_set_ids;

  ReorderInstalledStickerSets({
    this.extra,
    this.client_id,
    this.is_masks,
    this.sticker_set_ids,
  });

  ReorderInstalledStickerSets.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    is_masks = map['is_masks'];
    if (map['sticker_set_ids']) {
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
      'is_masks': is_masks?.toMap(skipNulls: skipNulls),
      'sticker_set_ids': sticker_set_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
