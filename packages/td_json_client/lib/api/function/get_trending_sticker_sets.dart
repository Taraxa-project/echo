import 'package:td_json_client/api/base.dart';


/// Returns a list of trending sticker sets. For optimal performance, the number of returned sticker sets is chosen by TDLib
class GetTrendingStickerSets extends TdFunction {
  String get tdType => 'getTrendingStickerSets';
  String get tdReturnType => 'TrendingStickerSets';


  /// The offset from which to return the sticker sets; must be non-negative
  int32? offset;

  /// The maximum number of sticker sets to be returned; up to 100. For optimal performance, the number of returned sticker sets is chosen by TDLib and can be smaller than the specified limit, even if the end of the list has not been reached
  int32? limit;

  GetTrendingStickerSets({
    super.extra,
    super.client_id,
    this.offset,
    this.limit,
  });

  GetTrendingStickerSets.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    offset = map['offset'];
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'offset': offset?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
