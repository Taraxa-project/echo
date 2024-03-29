import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/thumbnail.dart';
import 'package:td_json_client/src/td_api/object/closed_vector_path.dart';
import 'package:td_json_client/src/td_api/object/sticker_format.dart';
import 'package:td_json_client/src/td_api/object/sticker_type.dart';
import 'package:td_json_client/src/td_api/object/sticker.dart';
import 'package:td_json_client/src/td_api/object/emojis.dart';

/// Represents a sticker set
class StickerSet extends TdObject {
  String get tdType => 'stickerSet';

  /// Identifier of the sticker set
  int64? id;

  /// Title of the sticker set
  string? title;

  /// Name of the sticker set
  string? name;

  /// Sticker set thumbnail in WEBP, TGS, or WEBM format with width and height 100; may be null. The file can be downloaded only before the thumbnail is changed
  Thumbnail? thumbnail;

  /// Sticker set thumbnail's outline represented as a list of closed vector paths; may be empty. The coordinate system origin is in the upper-left corner
  vector<ClosedVectorPath>? thumbnail_outline;

  /// True, if the sticker set has been installed by the current user
  Bool? is_installed;

  /// True, if the sticker set has been archived. A sticker set can't be installed and archived simultaneously
  Bool? is_archived;

  /// True, if the sticker set is official
  Bool? is_official;

  /// Format of the stickers in the set
  StickerFormat? sticker_format;

  /// Type of the stickers in the set
  StickerType? sticker_type;

  /// True for already viewed trending sticker sets
  Bool? is_viewed;

  /// List of stickers in this set
  vector<Sticker>? stickers;

  /// A list of emoji corresponding to the stickers in the same order. The list is only for informational purposes, because a sticker is always sent with a fixed emoji from the corresponding Sticker object
  vector<Emojis>? emojis;

  StickerSet({
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
    this.sticker_format,
    this.sticker_type,
    this.is_viewed,
    this.stickers,
    this.emojis,
  });

  StickerSet.fromMap(Map<String, dynamic> map) {
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
    if (map['sticker_format'] != null) {
      sticker_format = TdApiMap.fromMap(map['sticker_format']) as StickerFormat;
    }
    if (map['sticker_type'] != null) {
      sticker_type = TdApiMap.fromMap(map['sticker_type']) as StickerType;
    }
    is_viewed = map['is_viewed'];
    if (map['stickers'] != null) {
      stickers = [];
      for (var someValue in map['stickers']) {
        if (someValue != null) {
          stickers?.add(TdApiMap.fromMap(someValue) as Sticker);
        }
      }
    }
    if (map['emojis'] != null) {
      emojis = [];
      for (var someValue in map['emojis']) {
        if (someValue != null) {
          emojis?.add(TdApiMap.fromMap(someValue) as Emojis);
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
      'sticker_format': sticker_format?.toMap(skipNulls: skipNulls),
      'sticker_type': sticker_type?.toMap(skipNulls: skipNulls),
      'is_viewed': is_viewed?.toMap(skipNulls: skipNulls),
      'stickers': stickers?.toMap(skipNulls: skipNulls),
      'emojis': emojis?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
