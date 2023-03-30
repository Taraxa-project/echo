import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/minithumbnail.dart';
import 'package:td_json_client/src/td_api/object/photo_size.dart';

/// Describes a photo
class Photo extends TdObject {
  String get tdType => 'photo';

  /// True, if stickers were added to the photo. The list of corresponding sticker sets can be received using getAttachedStickerSets
  Bool? has_stickers;

  /// Photo minithumbnail; may be null
  Minithumbnail? minithumbnail;

  /// Available variants of the photo, in different sizes
  vector<PhotoSize>? sizes;

  Photo({
    super.extra,
    super.client_id,
    this.has_stickers,
    this.minithumbnail,
    this.sizes,
  });

  Photo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    has_stickers = map['has_stickers'];
    if (map['minithumbnail'] != null) {
      minithumbnail = TdApiMap.fromMap(map['minithumbnail']) as Minithumbnail;
    }
    if (map['sizes'] != null) {
      sizes = [];
      for (var someValue in map['sizes']) {
        if (someValue != null) {
          sizes?.add(TdApiMap.fromMap(someValue) as PhotoSize);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'has_stickers': has_stickers?.toMap(skipNulls: skipNulls),
      'minithumbnail': minithumbnail?.toMap(skipNulls: skipNulls),
      'sizes': sizes?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
