import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/thumbnail.dart';
import 'package:td_json_client/api/object/closed_vector_path.dart';
import 'package:td_json_client/api/object/sticker.dart';


/// Represents short information about a sticker set
class StickerSetInfo extends TdObject {
  String get tdType => 'stickerSetInfo';


  /// Identifier of the sticker set 
  int64? id;

  /// Title of the sticker set 
  string? title;

  /// Name of the sticker set 
  string? name;

  /// Sticker set thumbnail in WEBP or TGS format with width and height 100; may be null
  Thumbnail? thumbnail;

  /// Sticker set thumbnail's outline represented as a list of closed vector paths; may be empty. The coordinate system origin is in the upper-left corner
  vector<ClosedVectorPath>? thumbnail_outline;

  /// True, if the sticker set has been installed by the current user 
  Bool? is_installed;

  /// True, if the sticker set has been archived. A sticker set can't be installed and archived simultaneously
  Bool? is_archived;

  /// True, if the sticker set is official 
  Bool? is_official;

  /// True, is the stickers in the set are animated 
  Bool? is_animated;

  /// True, if the stickers in the set are masks 
  Bool? is_masks;

  /// True for already viewed trending sticker sets
  Bool? is_viewed;

  /// Total number of stickers in the set 
  int32? size;

  /// Up to the first 5 stickers from the set, depending on the context. If the application needs more stickers the full sticker set needs to be requested
  vector<Sticker>? covers;

  StickerSetInfo({
    super.extra,
    super.client_id,
    this.id,
    this.title,
    this.name,
    this.thumbnail,
    this.thumbnail_outline,
    this.is_installed,
    this.is_archived,
    this.is_official,
    this.is_animated,
    this.is_masks,
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
    if (map['thumbnail'] != null) {
      thumbnail = TdApiMap.fromMap(map['thumbnail']) as Thumbnail;
    }
    if (map['thumbnail_outline'] != null) {
      thumbnail_outline = [];
      for (var someValue in map['thumbnail_outline']) {
        if (someValue != null) {
          thumbnail_outline?.add(TdApiMap.fromMap(someValue) as ClosedVectorPath);
        }
      }
    }
    is_installed = map['is_installed'];
    is_archived = map['is_archived'];
    is_official = map['is_official'];
    is_animated = map['is_animated'];
    is_masks = map['is_masks'];
    is_viewed = map['is_viewed'];
    size = map['size'];
    if (map['covers'] != null) {
      covers = [];
      for (var someValue in map['covers']) {
        if (someValue != null) {
          covers?.add(TdApiMap.fromMap(someValue) as Sticker);
        }
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
      'is_animated': is_animated?.toMap(skipNulls: skipNulls),
      'is_masks': is_masks?.toMap(skipNulls: skipNulls),
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
