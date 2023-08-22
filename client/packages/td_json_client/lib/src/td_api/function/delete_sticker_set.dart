import 'package:td_json_client/src/td_api/td.dart';

/// Deleted a sticker set; for bots only
class DeleteStickerSet extends TdFunction {
  String get tdType => 'deleteStickerSet';
  String get tdReturnType => 'Ok';

  /// Sticker set name
  string? name;

  DeleteStickerSet({
    super.extra,
    super.client_id,
    this.name,
  });

  DeleteStickerSet.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    name = map['name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
