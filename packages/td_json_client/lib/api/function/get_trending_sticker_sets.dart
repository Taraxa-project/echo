import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/sticker_type.dart';


/// Returns a list of trending sticker sets. For optimal performance, the number of returned sticker sets is chosen by TDLib
class GetTrendingStickerSets extends TdFunction {
  String get tdType => 'getTrendingStickerSets';
  String get tdReturnType => 'TrendingStickerSets';


  /// Type of the sticker sets to return
  StickerType? sticker_type;

  /// The offset from which to return the sticker sets; must be non-negative
  int32? offset;

  /// The maximum number of sticker sets to be returned; up to 100. For optimal performance, the number of returned sticker sets is chosen by TDLib and can be smaller than the specified limit, even if the end of the list has not been reached
  int32? limit;

  GetTrendingStickerSets({
    super.extra,
    super.client_id,
    this.sticker_type,
    this.offset,
    this.limit,
  });

  GetTrendingStickerSets.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sticker_type'] != null) {
      sticker_type = TdApiMap.fromMap(map['sticker_type']) as StickerType;
    }
    offset = map['offset'];
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sticker_type': sticker_type?.toMap(skipNulls: skipNulls),
      'offset': offset?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
