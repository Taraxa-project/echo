import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/sticker_format.dart';
import 'package:td_json_client/api/object/sticker_type.dart';
import 'package:td_json_client/api/object/mask_position.dart';
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

  /// Sticker format 
  StickerFormat? format;

  /// Sticker type 
  StickerType? type;

  /// Position where the mask is placed; may be null even the sticker is a mask
  MaskPosition? mask_position;

  /// Identifier of the emoji if the sticker is a custom emoji
  int64? custom_emoji_id;

  /// Sticker's outline represented as a list of closed vector paths; may be empty. The coordinate system origin is in the upper-left corner
  vector<ClosedVectorPath>? outline;

  /// Sticker thumbnail in WEBP or JPEG format; may be null 
  Thumbnail? thumbnail;

  /// True, if only Premium users can use the sticker 
  Bool? is_premium;

  /// Premium animation of the sticker; may be null 
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
    this.format,
    this.type,
    this.mask_position,
    this.custom_emoji_id,
    this.outline,
    this.thumbnail,
    this.is_premium,
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
    if (map['format'] != null) {
      format = TdApiMap.fromMap(map['format']) as StickerFormat;
    }
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as StickerType;
    }
    if (map['mask_position'] != null) {
      mask_position = TdApiMap.fromMap(map['mask_position']) as MaskPosition;
    }
    custom_emoji_id = map['custom_emoji_id'];
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
    is_premium = map['is_premium'];
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
      'format': format?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'mask_position': mask_position?.toMap(skipNulls: skipNulls),
      'custom_emoji_id': custom_emoji_id?.toMap(skipNulls: skipNulls),
      'outline': outline?.toMap(skipNulls: skipNulls),
      'thumbnail': thumbnail?.toMap(skipNulls: skipNulls),
      'is_premium': is_premium?.toMap(skipNulls: skipNulls),
      'premium_animation': premium_animation?.toMap(skipNulls: skipNulls),
      'sticker': sticker?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
