import 'package:td_json_client/api/base.dart';


/// Searches for installed sticker sets by looking for specified query in their title and name 
class SearchInstalledStickerSets extends TdFunction {
  String get tdType => 'searchInstalledStickerSets';
  String get tdReturnType => 'StickerSets';


  /// Pass true to return mask sticker sets; pass false to return ordinary sticker sets 
  Bool? is_masks;

  /// Query to search for 
  string? query;

  /// The maximum number of sticker sets to return
  int32? limit;

  SearchInstalledStickerSets({
    super.extra,
    super.client_id,
    this.is_masks,
    this.query,
    this.limit,
  });

  SearchInstalledStickerSets.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    is_masks = map['is_masks'];
    query = map['query'];
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'is_masks': is_masks?.toMap(skipNulls: skipNulls),
      'query': query?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
