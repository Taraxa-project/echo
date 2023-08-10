import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/sticker_type.dart';

/// Searches for stickers from public sticker sets that correspond to any of the given emoji
class SearchStickers extends TdFunction {
  String get tdType => 'searchStickers';
  String get tdReturnType => 'Stickers';

  /// Type of the stickers to return
  StickerType? sticker_type;

  /// Space-separated list of emoji to search for; must be non-empty
  string? emojis;

  /// The maximum number of stickers to be returned; 0-100
  int32? limit;

  SearchStickers({
    super.extra,
    super.client_id,
    this.sticker_type,
    this.emojis,
    this.limit,
  });

  SearchStickers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sticker_type'] != null) {
      sticker_type = TdApiMap.fromMap(map['sticker_type']) as StickerType;
    }
    emojis = map['emojis'];
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sticker_type': sticker_type?.toMap(skipNulls: skipNulls),
      'emojis': emojis?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
