import 'package:td_json_client/api/base.dart';


/// Returns stickers from the installed sticker sets that correspond to a given emoji. If the emoji is non-empty, favorite and recently used stickers may also be returned 
class GetStickers extends TdFunction {
  String get tdType => 'getStickers';
  String get tdReturnType => 'Stickers';


  /// String representation of emoji. If empty, returns all known installed stickers 
  string? emoji;

  /// The maximum number of stickers to be returned
  int32? limit;

  GetStickers({
    super.extra,
    super.client_id,
    this.emoji,
    this.limit,
  });

  GetStickers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    emoji = map['emoji'];
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'emoji': emoji?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
