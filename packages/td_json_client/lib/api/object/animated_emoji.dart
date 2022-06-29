import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/sticker.dart';
import 'package:td_json_client/api/object/file.dart';


/// Describes an animated representation of an emoji
class AnimatedEmoji extends TdObject {
  String get tdType => 'animatedEmoji';

  String? extra;
  int? client_id;

  /// Animated sticker for the emoji
  Sticker? sticker;

  /// Emoji modifier fitzpatrick type; 0-6; 0 if none
  int32? fitzpatrick_type;

  /// File containing the sound to be played when the animated emoji is clicked; may be null. The sound is encoded with the Opus codec, and stored inside an OGG container
  File? sound;

  AnimatedEmoji({
    this.extra,
    this.client_id,
    this.sticker,
    this.fitzpatrick_type,
    this.sound,
  });

  AnimatedEmoji.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sticker'] != null) {
      sticker = TdApiMap.fromMap(map['sticker']) as Sticker;
    }
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
      'fitzpatrick_type': fitzpatrick_type?.toMap(skipNulls: skipNulls),
      'sound': sound?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
