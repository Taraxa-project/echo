import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_chat_photo.dart';

class SetChatPhoto extends TdFunction {
  String get tdType => 'setChatPhoto';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int53? chat_id;
  InputChatPhoto? photo;

  SetChatPhoto({
    this.extra,
    this.client_id,
    this.chat_id,
    this.photo,
  });

  SetChatPhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    photo = TdApiMap.fromMap(map['photo']) as InputChatPhoto;
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