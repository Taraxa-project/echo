import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/file.dart';
import 'package:td_json_client/api/object/minithumbnail.dart';

class ChatPhotoInfo extends TdObject {
  String get tdType => 'chatPhotoInfo';

  String? extra;
  int? client_id;
  File? small;
  File? big;
  Minithumbnail? minithumbnail;
  Bool? has_animation;

  ChatPhotoInfo({
    this.extra,
    this.client_id,
    this.small,
    this.big,
    this.minithumbnail,
    this.has_animation,
  });

  ChatPhotoInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    small = TdApiMap.fromMap(map['small']) as File;
    big = TdApiMap.fromMap(map['big']) as File;
    minithumbnail = TdApiMap.fromMap(map['minithumbnail']) as Minithumbnail;
    has_animation = map['has_animation'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'small': small?.toMap(skipNulls: skipNulls),
      'big': big?.toMap(skipNulls: skipNulls),
      'minithumbnail': minithumbnail?.toMap(skipNulls: skipNulls),
      'has_animation': has_animation?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
