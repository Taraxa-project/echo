import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message.dart';

class MessageLinkInfo extends TdObject {
  String get tdType => 'messageLinkInfo';

  String? extra;
  int? client_id;
  Bool? is_public;
  int53? chat_id;
  Message? message;
  int32? media_timestamp;
  Bool? for_album;
  Bool? for_comment;

  MessageLinkInfo({
    this.extra,
    this.client_id,
    this.is_public,
    this.chat_id,
    this.message,
    this.media_timestamp,
    this.for_album,
    this.for_comment,
  });

  MessageLinkInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    is_public = map['is_public'];
    chat_id = map['chat_id'];
    message = TdApiMap.fromMap(map['message']) as Message;
    media_timestamp = map['media_timestamp'];
    for_album = map['for_album'];
    for_comment = map['for_comment'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'is_public': is_public?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message': message?.toMap(skipNulls: skipNulls),
      'media_timestamp': media_timestamp?.toMap(skipNulls: skipNulls),
      'for_album': for_album?.toMap(skipNulls: skipNulls),
      'for_comment': for_comment?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
