import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/file.dart';
import 'package:td_json_client/api/object/minithumbnail.dart';


/// Describes a user profile photo 
class ProfilePhoto extends TdObject {
  String get tdType => 'profilePhoto';


  /// Photo identifier; 0 for an empty photo. Can be used to find a photo in a list of user profile photos
  int64? id;

  /// A small (160x160) user profile photo. The file can be downloaded only before the photo is changed
  File? small;

  /// A big (640x640) user profile photo. The file can be downloaded only before the photo is changed
  File? big;

  /// User profile photo minithumbnail; may be null
  Minithumbnail? minithumbnail;

  /// True, if the photo has animated variant
  Bool? has_animation;

  ProfilePhoto({
    super.extra,
    super.client_id,
    this.id,
    this.small,
    this.big,
    this.minithumbnail,
    this.has_animation,
  });

  ProfilePhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
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
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
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
