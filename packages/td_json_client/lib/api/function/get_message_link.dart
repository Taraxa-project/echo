import 'package:td_json_client/api/base.dart';

/// Returns an HTTPS link to a message in a chat. Available only for already sent messages in supergroups and channels, or if message.can_get_media_timestamp_links and a media timestamp link is generated. This is an offline request
class GetMessageLink extends TdFunction {
  String get tdType => 'getMessageLink';
  String get tdReturnType => 'MessageLink';

  /// Identifier of the chat to which the message belongs
  int53? chat_id;

  /// Identifier of the message
  int53? message_id;

  /// If not 0, timestamp from which the video/audio/video note/voice note playing must start, in seconds. The media can be in the message content or in its web page preview
  int32? media_timestamp;

  /// Pass true to create a link for the whole media album
  Bool? for_album;

  /// Pass true to create a link to the message as a channel post comment, in a message thread, or a forum topic
  Bool? in_message_thread;

  GetMessageLink({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_id,
    this.media_timestamp,
    this.for_album,
    this.in_message_thread,
  });

  GetMessageLink.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    media_timestamp = map['media_timestamp'];
    for_album = map['for_album'];
    in_message_thread = map['in_message_thread'];
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
      'in_message_thread': in_message_thread?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
