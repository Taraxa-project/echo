import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/sticker.dart';
import 'package:td_json_client/api/object/file.dart';

class AnimatedEmoji extends TdObject {
  String get tdType => 'animatedEmoji';

  String? extra;
  int? client_id;
  Sticker? sticker;
  int32? fitzpatrick_type;
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
    sticker = TdApiMap.fromMap(map['sticker']) as Sticker;
    fitzpatrick_type = map['fitzpatrick_type'];
    sound = TdApiMap.fromMap(map['sound']) as File;
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
