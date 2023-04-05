import 'package:td_json_client/src/td_api/td.dart';

/// Searches for ordinary sticker sets by looking for specified query in their title and name. Excludes installed sticker sets from the results
class SearchStickerSets extends TdFunction {
  String get tdType => 'searchStickerSets';
  String get tdReturnType => 'StickerSets';

  /// Query to search for
  string? query;

  SearchStickerSets({
    super.extra,
    super.client_id,
    this.query,
  });

  SearchStickerSets.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    query = map['query'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'query': query?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
