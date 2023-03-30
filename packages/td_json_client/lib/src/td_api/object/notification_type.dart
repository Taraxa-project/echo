import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/message.dart';
import 'package:td_json_client/src/td_api/object/message_sender.dart';
import 'package:td_json_client/src/td_api/object/push_message_content.dart';

/// Contains detailed information about a notification
abstract class NotificationType extends TdObject {
  NotificationType({super.extra, super.client_id});
}

/// New message was received
class NotificationTypeNewMessage extends NotificationType {
  String get tdType => 'notificationTypeNewMessage';

  /// The message
  Message? message;

  /// True, if message content must be displayed in notifications
  Bool? show_preview;

  NotificationTypeNewMessage({
    super.extra,
    super.client_id,
    this.message,
    this.show_preview,
  });

  NotificationTypeNewMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['message'] != null) {
      message = TdApiMap.fromMap(map['message']) as Message;
    }
    show_preview = map['show_preview'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'message': message?.toMap(skipNulls: skipNulls),
      'show_preview': show_preview?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// New secret chat was created
class NotificationTypeNewSecretChat extends NotificationType {
  String get tdType => 'notificationTypeNewSecretChat';

  NotificationTypeNewSecretChat({
    super.extra,
    super.client_id,
  });

  NotificationTypeNewSecretChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// New call was received
class NotificationTypeNewCall extends NotificationType {
  String get tdType => 'notificationTypeNewCall';

  /// Call identifier
  int32? call_id;

  NotificationTypeNewCall({
    super.extra,
    super.client_id,
    this.call_id,
  });

  NotificationTypeNewCall.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    call_id = map['call_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'call_id': call_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// New message was received through a push notification
class NotificationTypeNewPushMessage extends NotificationType {
  String get tdType => 'notificationTypeNewPushMessage';

  /// The message identifier. The message will not be available in the chat history, but the ID can be used in viewMessages, or as reply_to_message_id
  int53? message_id;

  /// Identifier of the sender of the message. Corresponding user or chat may be inaccessible
  MessageSender? sender_id;

  /// Name of the sender
  string? sender_name;

  /// True, if the message is outgoing
  Bool? is_outgoing;

  /// Push message content
  PushMessageContent? content;

  NotificationTypeNewPushMessage({
    super.extra,
    super.client_id,
    this.message_id,
    this.sender_id,
    this.sender_name,
    this.is_outgoing,
    this.content,
  });

  NotificationTypeNewPushMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    message_id = map['message_id'];
    if (map['sender_id'] != null) {
      sender_id = TdApiMap.fromMap(map['sender_id']) as MessageSender;
    }
    sender_name = map['sender_name'];
    is_outgoing = map['is_outgoing'];
    if (map['content'] != null) {
      content = TdApiMap.fromMap(map['content']) as PushMessageContent;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'sender_id': sender_id?.toMap(skipNulls: skipNulls),
      'sender_name': sender_name?.toMap(skipNulls: skipNulls),
      'is_outgoing': is_outgoing?.toMap(skipNulls: skipNulls),
      'content': content?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
