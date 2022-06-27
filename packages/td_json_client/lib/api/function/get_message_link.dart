import 'package:td_json_client/api/base.dart';

class GetMessageLink extends TdFunction {
  String get tdType => 'getMessageLink';
  String get tdReturnType => 'MessageLink';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? message_id;
  int32? media_timestamp;
  Bool? for_album;
  Bool? for_comment;

  GetMessageLink({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_id,
    this.media_timestamp,
    this.for_album,
    this.for_comment,
  });

  GetMessageLink.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    media_timestamp = map['media_timestamp'];
    for_album = map['for_album'];
    for_comment = map['for_comment'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
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