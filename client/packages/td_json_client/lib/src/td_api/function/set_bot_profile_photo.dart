import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/input_chat_photo.dart';

/// Changes a profile photo for a bot
class SetBotProfilePhoto extends TdFunction {
  String get tdType => 'setBotProfilePhoto';
  String get tdReturnType => 'Ok';

  /// Identifier of the target bot
  int53? bot_user_id;

  /// Profile photo to set; pass null to delete the chat photo
  InputChatPhoto? photo;

  SetBotProfilePhoto({
    super.extra,
    super.client_id,
    this.bot_user_id,
    this.photo,
  });

  SetBotProfilePhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_user_id = map['bot_user_id'];
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as InputChatPhoto;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bot_user_id': bot_user_id?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
