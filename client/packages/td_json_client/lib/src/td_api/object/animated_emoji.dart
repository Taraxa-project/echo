import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/sticker.dart';
import 'package:td_json_client/src/td_api/object/file.dart';

/// Describes an animated or custom representation of an emoji
class AnimatedEmoji extends TdObject {
  String get tdType => 'animatedEmoji';

  /// Sticker for the emoji; may be null if yet unknown for a custom emoji. If the sticker is a custom emoji, it can have arbitrary format different from stickerFormatTgs
  Sticker? sticker;

  /// Expected width of the sticker, which can be used if the sticker is null
  int32? sticker_width;

  /// Expected height of the sticker, which can be used if the sticker is null
  int32? sticker_height;

  /// Emoji modifier fitzpatrick type; 0-6; 0 if none
  int32? fitzpatrick_type;

  /// File containing the sound to be played when the sticker is clicked; may be null. The sound is encoded with the Opus codec, and stored inside an OGG container
  File? sound;

  AnimatedEmoji({
    super.extra,
    super.client_id,
    this.sticker,
    this.sticker_width,
    this.sticker_height,
    this.fitzpatrick_type,
    this.sound,
  });

  AnimatedEmoji.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sticker'] != null) {
      sticker = TdApiMap.fromMap(map['sticker']) as Sticker;
    }
    sticker_width = map['sticker_width'];
    sticker_height = map['sticker_height'];
    fitzpatrick_type = map['fitzpatrick_type'];
    if (map['sound'] != null) {
      sound = TdApiMap.fromMap(map['sound']) as File;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sticker': sticker?.toMap(skipNulls: skipNulls),
      'sticker_width': sticker_width?.toMap(skipNulls: skipNulls),
      'sticker_height': sticker_height?.toMap(skipNulls: skipNulls),
      'fitzpatrick_type': fitzpatrick_type?.toMap(skipNulls: skipNulls),
      'sound': sound?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
