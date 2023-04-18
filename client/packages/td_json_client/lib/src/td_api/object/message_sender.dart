import 'package:td_json_client/src/td_api/td.dart';

/// Contains information about the sender of a message
abstract class MessageSender extends TdObject {
  MessageSender({super.extra, super.client_id});
}

/// The message was sent by a known user
class MessageSenderUser extends MessageSender {
  String get tdType => 'messageSenderUser';

  /// Identifier of the user that sent the message
  int53? user_id;

  MessageSenderUser({
    super.extra,
    super.client_id,
    this.user_id,
  });

  MessageSenderUser.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The message was sent on behalf of a chat
class MessageSenderChat extends MessageSender {
  String get tdType => 'messageSenderChat';

  /// Identifier of the chat that sent the message
  int53? chat_id;

  MessageSenderChat({
    super.extra,
    super.client_id,
    this.chat_id,
  });

  MessageSenderChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
