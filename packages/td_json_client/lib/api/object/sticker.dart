import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/sticker_type.dart';
import 'package:td_json_client/api/object/closed_vector_path.dart';
import 'package:td_json_client/api/object/thumbnail.dart';
import 'package:td_json_client/api/object/file.dart';


/// Describes a sticker 
class Sticker extends TdObject {
  String get tdType => 'sticker';


  /// The identifier of the sticker set to which the sticker belongs; 0 if none 
  int64? set_id;

  /// Sticker width; as defined by the sender 
  int32? width;

  /// Sticker height; as defined by the sender
  int32? height;

  /// Emoji corresponding to the sticker 
  string? emoji;

  /// Sticker type 
  StickerType? type;

  /// Sticker's outline represented as a list of closed vector paths; may be empty. The coordinate system origin is in the upper-left corner
  vector<ClosedVectorPath>? outline;

  /// Sticker thumbnail in WEBP or JPEG format; may be null 
  Thumbnail? thumbnail;

  /// Premium animation of the sticker; may be null. If present, only Premium users can send the sticker 
  File? premium_animation;

  /// File containing the sticker
  File? sticker;

  Sticker({
    super.extra,
    super.client_id,
    this.set_id,
    this.width,
    this.height,
    this.emoji,
    this.type,
    this.outline,
    this.thumbnail,
    this.premium_animation,
    this.sticker,
  });

  Sticker.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    set_id = map['set_id'];
    width = map['width'];
    height = map['height'];
    emoji = map['emoji'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as StickerType;
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
    if (map['premium_animation'] != null) {
      premium_animation = TdApiMap.fromMap(map['premium_animation']) as File;
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
      'set_id': set_id?.toMap(skipNulls: skipNulls),
      'width': width?.toMap(skipNulls: skipNulls),
      'height': height?.toMap(skipNulls: skipNulls),
      'emoji': emoji?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'outline': outline?.toMap(skipNulls: skipNulls),
      'thumbnail': thumbnail?.toMap(skipNulls: skipNulls),
      'premium_animation': premium_animation?.toMap(skipNulls: skipNulls),
      'sticker': sticker?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
