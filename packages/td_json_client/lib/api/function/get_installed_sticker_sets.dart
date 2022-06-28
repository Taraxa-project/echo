import 'package:td_json_client/api/base.dart';


/// Returns a list of installed sticker sets 
class GetInstalledStickerSets extends TdFunction {
  String get tdType => 'getInstalledStickerSets';
  String get tdReturnType => 'StickerSets';

  String? extra;
  int? client_id;

  /// Pass true to return mask sticker sets; pass false to return ordinary sticker sets
  Bool? is_masks;

  GetInstalledStickerSets({
    this.extra,
    this.client_id,
    this.is_masks,
  });

  GetInstalledStickerSets.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    is_masks = map['is_masks'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'is_masks': is_masks?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
