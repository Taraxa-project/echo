import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message.dart';
import 'package:td_json_client/api/object/message_sender.dart';
import 'package:td_json_client/api/object/push_message_content.dart';

abstract class NotificationType extends TdObject {}

class NotificationTypeNewMessage extends NotificationType {
  String get tdType => 'notificationTypeNewMessage';

  string? extra;
  int? client_id;
  Message? message;

  NotificationTypeNewMessage({
    this.extra,
    this.client_id,
    this.message,
  });

  NotificationTypeNewMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    message = TdApiMap.fromMap(map['message']) as Message;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'message': message?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class NotificationTypeNewSecretChat extends NotificationType {
  String get tdType => 'notificationTypeNewSecretChat';

  string? extra;
  int? client_id;

  NotificationTypeNewSecretChat({
    this.extra,
    this.client_id,
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
class NotificationTypeNewCall extends NotificationType {
  String get tdType => 'notificationTypeNewCall';

  string? extra;
  int? client_id;
  int32? call_id;

  NotificationTypeNewCall({
    this.extra,
    this.client_id,
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
class NotificationTypeNewPushMessage extends NotificationType {
  String get tdType => 'notificationTypeNewPushMessage';

  string? extra;
  int? client_id;
  int53? message_id;
  MessageSender? sender_id;
  string? sender_name;
  Bool? is_outgoing;
  PushMessageContent? content;

  NotificationTypeNewPushMessage({
    this.extra,
    this.client_id,
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
    sender_id = TdApiMap.fromMap(map['sender_id']) as MessageSender;
    sender_name = map['sender_name'];
    is_outgoing = map['is_outgoing'];
    content = TdApiMap.fromMap(map['content']) as PushMessageContent;
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
