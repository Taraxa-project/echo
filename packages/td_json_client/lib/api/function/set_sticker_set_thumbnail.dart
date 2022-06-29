import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_file.dart';


/// Sets a sticker set thumbnail; for bots only. Returns the sticker set
class SetStickerSetThumbnail extends TdFunction {
  String get tdType => 'setStickerSetThumbnail';
  String get tdReturnType => 'StickerSet';

  String? extra;
  int? client_id;

  /// Sticker set owner 
  int53? user_id;

  /// Sticker set name
  string? name;

  /// Thumbnail to set in PNG or TGS format; pass null to remove the sticker set thumbnail. Animated thumbnail must be set for animated sticker sets and only for them
  InputFile? thumbnail;

  SetStickerSetThumbnail({
    this.extra,
    this.client_id,
    this.user_id,
    this.name,
    this.thumbnail,
  });

  SetStickerSetThumbnail.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    name = map['name'];
    if (map['thumbnail'] != null) {
      thumbnail = TdApiMap.fromMap(map['thumbnail']) as InputFile;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
      'thumbnail': thumbnail?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
