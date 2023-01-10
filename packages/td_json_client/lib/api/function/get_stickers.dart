import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/sticker_type.dart';


/// Returns stickers from the installed sticker sets that correspond to a given emoji. If the emoji is non-empty, then favorite, recently used or trending stickers may also be returned
class GetStickers extends TdFunction {
  String get tdType => 'getStickers';
  String get tdReturnType => 'Stickers';


  /// Type of the sticker sets to return
  StickerType? sticker_type;

  /// String representation of emoji. If empty, returns all known installed stickers
  string? emoji;

  /// The maximum number of stickers to be returned
  int32? limit;

  /// Chat identifier for which to return stickers. Available custom emoji may be different for different chats
  int53? chat_id;

  GetStickers({
    super.extra,
    super.client_id,
    this.sticker_type,
    this.emoji,
    this.limit,
    this.chat_id,
  });

  GetStickers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sticker_type'] != null) {
      sticker_type = TdApiMap.fromMap(map['sticker_type']) as StickerType;
    }
    emoji = map['emoji'];
    limit = map['limit'];
    chat_id = map['chat_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sticker_type': sticker_type?.toMap(skipNulls: skipNulls),
      'emoji': emoji?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
