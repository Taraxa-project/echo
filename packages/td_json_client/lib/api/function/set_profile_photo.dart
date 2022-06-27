import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_chat_photo.dart';

class SetProfilePhoto extends TdFunction {
  String get tdType => 'setProfilePhoto';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  InputChatPhoto? photo;

  SetProfilePhoto({
    this.extra,
    this.client_id,
    this.photo,
  });

  SetProfilePhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    photo = TdApiMap.fromMap(map['photo']) as InputChatPhoto;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
