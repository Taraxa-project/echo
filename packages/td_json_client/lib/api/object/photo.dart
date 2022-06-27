import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/minithumbnail.dart';
import 'package:td_json_client/api/object/photo_size.dart';

class Photo extends TdObject {
  String get tdType => 'photo';

  string? extra;
  int? client_id;
  Bool? has_stickers;
  Minithumbnail? minithumbnail;
  vector<PhotoSize>? sizes;

  Photo({
    this.extra,
    this.client_id,
    this.has_stickers,
    this.minithumbnail,
    this.sizes,
  });

  Photo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    has_stickers = map['has_stickers'];
    minithumbnail = TdApiMap.fromMap(map['minithumbnail']) as Minithumbnail;
    if (map['sizes']) {
      sizes = [];
      for (var someValue in map['sizes']) {
        sizes?.add(TdApiMap.fromMap(someValue) as PhotoSize);
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
