import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_chat_photo.dart';


/// Changes a profile photo for the current user 
class SetProfilePhoto extends TdFunction {
  String get tdType => 'setProfilePhoto';
  String get tdReturnType => 'Ok';


  /// Profile photo to set 
  InputChatPhoto? photo;

  /// Pass true to set a public photo, which will be visible even the main photo is hidden by privacy settings
  Bool? is_public;

  SetProfilePhoto({
    super.extra,
    super.client_id,
    this.photo,
    this.is_public,
  });

  SetProfilePhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as InputChatPhoto;
    }
    is_public = map['is_public'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
      'is_public': is_public?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
