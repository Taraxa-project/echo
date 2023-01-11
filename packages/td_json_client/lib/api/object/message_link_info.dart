import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message.dart';


/// Contains information about a link to a message or a forum topic in a chat
class MessageLinkInfo extends TdObject {
  String get tdType => 'messageLinkInfo';


  /// True, if the link is a public link for a message or a forum topic in a chat
  Bool? is_public;

  /// If found, identifier of the chat to which the link points, 0 otherwise
  int53? chat_id;

  /// If found, identifier of the message thread in which to open the message, or a forum topic to open if the message is missing
  int53? message_thread_id;

  /// If found, the linked message; may be null
  Message? message;

  /// Timestamp from which the video/audio/video note/voice note playing must start, in seconds; 0 if not specified. The media can be in the message content or in its web page preview
  int32? media_timestamp;

  /// True, if the whole media album to which the message belongs is linked
  Bool? for_album;

  MessageLinkInfo({
    super.extra,
    super.client_id,
    this.is_public,
    this.chat_id,
    this.message_thread_id,
    this.message,
    this.media_timestamp,
    this.for_album,
  });

  MessageLinkInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    is_public = map['is_public'];
    chat_id = map['chat_id'];
    message_thread_id = map['message_thread_id'];
    if (map['message'] != null) {
      message = TdApiMap.fromMap(map['message']) as Message;
    }
    media_timestamp = map['media_timestamp'];
    for_album = map['for_album'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'is_public': is_public?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_thread_id': message_thread_id?.toMap(skipNulls: skipNulls),
      'message': message?.toMap(skipNulls: skipNulls),
      'media_timestamp': media_timestamp?.toMap(skipNulls: skipNulls),
      'for_album': for_album?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
