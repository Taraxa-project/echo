import 'package:td_json_client/api/base.dart';

class SearchInstalledStickerSets extends TdFunction {
  String get tdType => 'searchInstalledStickerSets';
  String get tdReturnType => 'StickerSets';

  string? extra;
  int? client_id;
  Bool? is_masks;
  string? query;
  int32? limit;

  SearchInstalledStickerSets({
    this.extra,
    this.client_id,
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