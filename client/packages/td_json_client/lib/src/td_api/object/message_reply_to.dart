import 'package:td_json_client/src/td_api/td.dart';

/// Contains information about the message or the story a message is replying to
abstract class MessageReplyTo extends TdObject {
  MessageReplyTo({super.extra, super.client_id});
}

/// Describes a replied message
class MessageReplyToMessage extends MessageReplyTo {
  String get tdType => 'messageReplyToMessage';

  /// The identifier of the chat to which the replied message belongs; ignored for outgoing replies. For example, messages in the Replies chat are replies to messages in different chats
  int53? chat_id;

  /// The identifier of the replied message
  int53? message_id;

  MessageReplyToMessage({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_id,
  });

  MessageReplyToMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Describes a replied story
class MessageReplyToStory extends MessageReplyTo {
  String get tdType => 'messageReplyToStory';

  /// The identifier of the sender of the replied story. Currently, stories can be replied only in the sender's chat
  int53? story_sender_chat_id;

  /// The identifier of the replied story
  int32? story_id;

  MessageReplyToStory({
    super.extra,
    super.client_id,
    this.story_sender_chat_id,
    this.story_id,
  });

  MessageReplyToStory.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    story_sender_chat_id = map['story_sender_chat_id'];
    story_id = map['story_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'story_sender_chat_id': story_sender_chat_id?.toMap(skipNulls: skipNulls),
      'story_id': story_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
