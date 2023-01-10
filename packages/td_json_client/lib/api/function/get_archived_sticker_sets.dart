import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/sticker_type.dart';


/// Returns a list of archived sticker sets 
class GetArchivedStickerSets extends TdFunction {
  String get tdType => 'getArchivedStickerSets';
  String get tdReturnType => 'StickerSets';


  /// Type of the sticker sets to return 
  StickerType? sticker_type;

  /// Identifier of the sticker set from which to return the result 
  int64? offset_sticker_set_id;

  /// The maximum number of sticker sets to return; up to 100
  int32? limit;

  GetArchivedStickerSets({
    super.extra,
    super.client_id,
    this.sticker_type,
    this.offset_sticker_set_id,
    this.limit,
  });

  GetArchivedStickerSets.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sticker_type'] != null) {
      sticker_type = TdApiMap.fromMap(map['sticker_type']) as StickerType;
    }
    offset_sticker_set_id = map['offset_sticker_set_id'];
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sticker_type': sticker_type?.toMap(skipNulls: skipNulls),
      'offset_sticker_set_id': offset_sticker_set_id?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
