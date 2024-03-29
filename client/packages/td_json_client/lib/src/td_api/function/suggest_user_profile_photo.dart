import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/input_chat_photo.dart';

/// Suggests a profile photo to another regular user with common messages
class SuggestUserProfilePhoto extends TdFunction {
  String get tdType => 'suggestUserProfilePhoto';
  String get tdReturnType => 'Ok';

  /// User identifier
  int53? user_id;

  /// Profile photo to suggest; inputChatPhotoPrevious isn't supported in this function
  InputChatPhoto? photo;

  SuggestUserProfilePhoto({
    super.extra,
    super.client_id,
    this.user_id,
    this.photo,
  });

  SuggestUserProfilePhoto.fromMap(Map<String, dynamic> map) {
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
