import 'package:td_json_client/api/base.dart';


/// Returns a list of archived sticker sets 
class GetArchivedStickerSets extends TdFunction {
  String get tdType => 'getArchivedStickerSets';
  String get tdReturnType => 'StickerSets';


  /// Pass true to return mask stickers sets; pass false to return ordinary sticker sets 
  Bool? is_masks;

  /// Identifier of the sticker set from which to return the result 
  int64? offset_sticker_set_id;

  /// The maximum number of sticker sets to return; up to 100
  int32? limit;

  GetArchivedStickerSets({
    super.extra,
    super.client_id,
    this.is_masks,
    this.offset_sticker_set_id,
    this.limit,
  });

  GetArchivedStickerSets.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    is_masks = map['is_masks'];
    offset_sticker_set_id = map['offset_sticker_set_id'];
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'is_masks': is_masks?.toMap(skipNulls: skipNulls),
      'offset_sticker_set_id': offset_sticker_set_id?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
