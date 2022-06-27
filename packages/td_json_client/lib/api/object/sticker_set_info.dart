import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/thumbnail.dart';
import 'package:td_json_client/api/object/closed_vector_path.dart';
import 'package:td_json_client/api/object/sticker_type.dart';
import 'package:td_json_client/api/object/sticker.dart';

class StickerSetInfo extends TdObject {
  String get tdType => 'stickerSetInfo';

  string? extra;
  int? client_id;
  int64? id;
  string? title;
  string? name;
  Thumbnail? thumbnail;
  vector<ClosedVectorPath>? thumbnail_outline;
  Bool? is_installed;
  Bool? is_archived;
  Bool? is_official;
  StickerType? sticker_type;
  Bool? is_viewed;
  int32? size;
  vector<Sticker>? covers;

  StickerSetInfo({
    this.extra,
    this.client_id,
    this.id,
    this.title,
    this.name,
    this.thumbnail,
    this.thumbnail_outline,
    this.is_installed,
    this.is_archived,
    this.is_official,
    this.sticker_type,
    this.is_viewed,
    this.size,
    this.covers,
  });

  StickerSetInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    title = map['title'];
    name = map['name'];
    thumbnail = TdApiMap.fromMap(map['thumbnail']) as Thumbnail;
    if (map['thumbnail_outline']) {
      thumbnail_outline = [];
      for (var someValue in map['thumbnail_outline']) {
        thumbnail_outline?.add(TdApiMap.fromMap(someValue) as ClosedVectorPath);
      }
    }
    is_installed = map['is_installed'];
    is_archived = map['is_archived'];
    is_official = map['is_official'];
    sticker_type = TdApiMap.fromMap(map['sticker_type']) as StickerType;
    is_viewed = map['is_viewed'];
    size = map['size'];
    if (map['covers']) {
      covers = [];
      for (var someValue in map['covers']) {
        covers?.add(TdApiMap.fromMap(someValue) as Sticker);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
      'thumbnail': thumbnail?.toMap(skipNulls: skipNulls),
      'thumbnail_outline': thumbnail_outline?.toMap(skipNulls: skipNulls),
      'is_installed': is_installed?.toMap(skipNulls: skipNulls),
      'is_archived': is_archived?.toMap(skipNulls: skipNulls),
      'is_official': is_official?.toMap(skipNulls: skipNulls),
      'sticker_type': sticker_type?.toMap(skipNulls: skipNulls),
      'is_viewed': is_viewed?.toMap(skipNulls: skipNulls),
      'size': size?.toMap(skipNulls: skipNulls),
      'covers': covers?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
