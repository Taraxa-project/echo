import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/sticker_type.dart';

/// Searches for installed sticker sets by looking for specified query in their title and name
class SearchInstalledStickerSets extends TdFunction {
  String get tdType => 'searchInstalledStickerSets';
  String get tdReturnType => 'StickerSets';

  /// Type of the sticker sets to search for
  StickerType? sticker_type;

  /// Query to search for
  string? query;

  /// The maximum number of sticker sets to return
  int32? limit;

  SearchInstalledStickerSets({
    super.extra,
    super.client_id,
    this.sticker_type,
    this.query,
    this.limit,
  });

  SearchInstalledStickerSets.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sticker_type'] != null) {
      sticker_type = TdApiMap.fromMap(map['sticker_type']) as StickerType;
    }
    query = map['query'];
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sticker_type': sticker_type?.toMap(skipNulls: skipNulls),
      'query': query?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
