import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/sticker_format.dart';
import 'package:td_json_client/src/td_api/object/sticker_full_type.dart';
import 'package:td_json_client/src/td_api/object/closed_vector_path.dart';
import 'package:td_json_client/src/td_api/object/thumbnail.dart';
import 'package:td_json_client/src/td_api/object/file.dart';

/// Describes a sticker
class Sticker extends TdObject {
  String get tdType => 'sticker';

  /// Unique sticker identifier within the set; 0 if none
  int64? id;

  /// Identifier of the sticker set to which the sticker belongs; 0 if none
  int64? set_id;

  /// Sticker width; as defined by the sender
  int32? width;

  /// Sticker height; as defined by the sender
  int32? height;

  /// Emoji corresponding to the sticker
  string? emoji;

  /// Sticker format
  StickerFormat? format;

  /// Sticker's full type
  StickerFullType? full_type;

  /// Sticker's outline represented as a list of closed vector paths; may be empty. The coordinate system origin is in the upper-left corner
  vector<ClosedVectorPath>? outline;

  /// Sticker thumbnail in WEBP or JPEG format; may be null
  Thumbnail? thumbnail;

  /// File containing the sticker
  File? sticker;

  Sticker({
    super.extra,
    super.client_id,
    this.id,
    this.set_id,
    this.width,
    this.height,
    this.emoji,
    this.format,
    this.full_type,
    this.outline,
    this.thumbnail,
    this.sticker,
  });

  Sticker.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    set_id = map['set_id'];
    width = map['width'];
    height = map['height'];
    emoji = map['emoji'];
    if (map['format'] != null) {
      format = TdApiMap.fromMap(map['format']) as StickerFormat;
    }
    if (map['full_type'] != null) {
      full_type = TdApiMap.fromMap(map['full_type']) as StickerFullType;
    }
    if (map['outline'] != null) {
      outline = [];
      for (var someValue in map['outline']) {
        if (someValue != null) {
          outline?.add(TdApiMap.fromMap(someValue) as ClosedVectorPath);
        }
      }
    }
    if (map['thumbnail'] != null) {
      thumbnail = TdApiMap.fromMap(map['thumbnail']) as Thumbnail;
    }
    if (map['sticker'] != null) {
      sticker = TdApiMap.fromMap(map['sticker']) as File;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'set_id': set_id?.toMap(skipNulls: skipNulls),
      'width': width?.toMap(skipNulls: skipNulls),
      'height': height?.toMap(skipNulls: skipNulls),
      'emoji': emoji?.toMap(skipNulls: skipNulls),
      'format': format?.toMap(skipNulls: skipNulls),
      'full_type': full_type?.toMap(skipNulls: skipNulls),
      'outline': outline?.toMap(skipNulls: skipNulls),
      'thumbnail': thumbnail?.toMap(skipNulls: skipNulls),
      'sticker': sticker?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
