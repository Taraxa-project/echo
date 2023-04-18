import 'package:td_json_client/src/td_api/td.dart';

/// Contains information about the origin of a forwarded message
abstract class MessageForwardOrigin extends TdObject {
  MessageForwardOrigin({super.extra, super.client_id});
}

/// The message was originally sent by a known user
class MessageForwardOriginUser extends MessageForwardOrigin {
  String get tdType => 'messageForwardOriginUser';

  /// Identifier of the user that originally sent the message
  int53? sender_user_id;

  MessageForwardOriginUser({
    super.extra,
    super.client_id,
    this.sender_user_id,
  });

  MessageForwardOriginUser.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    sender_user_id = map['sender_user_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sender_user_id': sender_user_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The message was originally sent on behalf of a chat
class MessageForwardOriginChat extends MessageForwardOrigin {
  String get tdType => 'messageForwardOriginChat';

  /// Identifier of the chat that originally sent the message
  int53? sender_chat_id;

  /// For messages originally sent by an anonymous chat administrator, original message author signature
  string? author_signature;

  MessageForwardOriginChat({
    super.extra,
    super.client_id,
    this.sender_chat_id,
    this.author_signature,
  });

  MessageForwardOriginChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    sender_chat_id = map['sender_chat_id'];
    author_signature = map['author_signature'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sender_chat_id': sender_chat_id?.toMap(skipNulls: skipNulls),
      'author_signature': author_signature?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The message was originally sent by a user, which is hidden by their privacy settings
class MessageForwardOriginHiddenUser extends MessageForwardOrigin {
  String get tdType => 'messageForwardOriginHiddenUser';

  /// Name of the sender
  string? sender_name;

  MessageForwardOriginHiddenUser({
    super.extra,
    super.client_id,
    this.sender_name,
  });

  MessageForwardOriginHiddenUser.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    sender_name = map['sender_name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sender_name': sender_name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The message was originally a post in a channel
class MessageForwardOriginChannel extends MessageForwardOrigin {
  String get tdType => 'messageForwardOriginChannel';

  /// Identifier of the chat from which the message was originally forwarded
  int53? chat_id;

  /// Message identifier of the original message
  int53? message_id;

  /// Original post author signature
  string? author_signature;

  MessageForwardOriginChannel({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_id,
    this.author_signature,
  });

  MessageForwardOriginChannel.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    author_signature = map['author_signature'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'author_signature': author_signature?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The message was imported from an exported message history
class MessageForwardOriginMessageImport extends MessageForwardOrigin {
  String get tdType => 'messageForwardOriginMessageImport';

  /// Name of the sender
  string? sender_name;

  MessageForwardOriginMessageImport({
    super.extra,
    super.client_id,
    this.sender_name,
  });

  MessageForwardOriginMessageImport.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    sender_name = map['sender_name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sender_name': sender_name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
