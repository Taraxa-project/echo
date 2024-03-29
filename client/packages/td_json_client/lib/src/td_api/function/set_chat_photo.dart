import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/input_chat_photo.dart';

/// Changes the photo of a chat. Supported only for basic groups, supergroups and channels. Requires can_change_info administrator right
class SetChatPhoto extends TdFunction {
  String get tdType => 'setChatPhoto';
  String get tdReturnType => 'Ok';

  /// Chat identifier
  int53? chat_id;

  /// New chat photo; pass null to delete the chat photo
  InputChatPhoto? photo;

  SetChatPhoto({
    super.extra,
    super.client_id,
    this.chat_id,
    this.photo,
  });

  SetChatPhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as InputChatPhoto;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
