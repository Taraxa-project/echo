import 'package:td_json_client/src/td_api/td.dart';

/// Returns information about a sticker set by its identifier
class GetStickerSet extends TdFunction {
  String get tdType => 'getStickerSet';
  String get tdReturnType => 'StickerSet';

  /// Identifier of the sticker set
  int64? set_id;

  GetStickerSet({
    super.extra,
    super.client_id,
    this.set_id,
  });

  GetStickerSet.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    set_id = map['set_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'set_id': set_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
