import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/mask_position.dart';
import 'package:td_json_client/api/object/closed_vector_path.dart';
import 'package:td_json_client/api/object/thumbnail.dart';
import 'package:td_json_client/api/object/file.dart';


/// Describes a sticker 
class Sticker extends TdObject {
  String get tdType => 'sticker';

  String? extra;
  int? client_id;

  /// The identifier of the sticker set to which the sticker belongs; 0 if none 
  int64? set_id;

  /// Sticker width; as defined by the sender 
  int32? width;

  /// Sticker height; as defined by the sender
  int32? height;

  /// Emoji corresponding to the sticker 
  string? emoji;

  /// True, if the sticker is an animated sticker in TGS format 
  Bool? is_animated;

  /// True, if the sticker is a mask 
  Bool? is_mask;

  /// Position where the mask is placed; may be null
  MaskPosition? mask_position;

  /// Sticker's outline represented as a list of closed vector paths; may be empty. The coordinate system origin is in the upper-left corner 
  vector<ClosedVectorPath>? outline;

  /// Sticker thumbnail in WEBP or JPEG format; may be null 
  Thumbnail? thumbnail;

  /// File containing the sticker
  File? sticker;

  Sticker({
    this.extra,
    this.client_id,
    this.set_id,
    this.width,
    this.height,
    this.emoji,
    this.is_animated,
    this.is_mask,
    this.mask_position,
    this.outline,
    this.thumbnail,
    this.sticker,
  });

  Sticker.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    set_id = map['set_id'];
    width = map['width'];
    height = map['height'];
    emoji = map['emoji'];
    is_animated = map['is_animated'];
    is_mask = map['is_mask'];
    if (map['mask_position'] != null) {
      mask_position = TdApiMap.fromMap(map['mask_position']) as MaskPosition;
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
      'set_id': set_id?.toMap(skipNulls: skipNulls),
      'width': width?.toMap(skipNulls: skipNulls),
      'height': height?.toMap(skipNulls: skipNulls),
      'emoji': emoji?.toMap(skipNulls: skipNulls),
      'is_animated': is_animated?.toMap(skipNulls: skipNulls),
      'is_mask': is_mask?.toMap(skipNulls: skipNulls),
      'mask_position': mask_position?.toMap(skipNulls: skipNulls),
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
