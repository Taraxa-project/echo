import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/file.dart';
import 'package:td_json_client/src/td_api/object/minithumbnail.dart';

/// Contains basic information about the photo of a chat
class ChatPhotoInfo extends TdObject {
  String get tdType => 'chatPhotoInfo';

  /// A small (160x160) chat photo variant in JPEG format. The file can be downloaded only before the photo is changed
  File? small;

  /// A big (640x640) chat photo variant in JPEG format. The file can be downloaded only before the photo is changed
  File? big;

  /// Chat photo minithumbnail; may be null
  Minithumbnail? minithumbnail;

  /// True, if the photo has animated variant
  Bool? has_animation;

  /// True, if the photo is visible only for the current user
  Bool? is_personal;

  ChatPhotoInfo({
    super.extra,
    super.client_id,
    this.small,
    this.big,
    this.minithumbnail,
    this.has_animation,
    this.is_personal,
  });

  ChatPhotoInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['small'] != null) {
      small = TdApiMap.fromMap(map['small']) as File;
    }
    if (map['big'] != null) {
      big = TdApiMap.fromMap(map['big']) as File;
    }
    if (map['minithumbnail'] != null) {
      minithumbnail = TdApiMap.fromMap(map['minithumbnail']) as Minithumbnail;
    }
    has_animation = map['has_animation'];
    is_personal = map['is_personal'];
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
      'is_personal': is_personal?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
