import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_chat_photo.dart';


/// Changes a personal profile photo of a contact user 
class SetUserPersonalProfilePhoto extends TdFunction {
  String get tdType => 'setUserPersonalProfilePhoto';
  String get tdReturnType => 'Ok';


  /// User identifier 
  int53? user_id;

  /// Profile photo to set; pass null to delete the photo; inputChatPhotoPrevious isn't supported in this function
  InputChatPhoto? photo;

  SetUserPersonalProfilePhoto({
    super.extra,
    super.client_id,
    this.user_id,
    this.photo,
  });

  SetUserPersonalProfilePhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as InputChatPhoto;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
