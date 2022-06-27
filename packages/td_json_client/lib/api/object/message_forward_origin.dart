import 'package:td_json_client/api/base.dart';

abstract class MessageForwardOrigin extends TdObject {}

class MessageForwardOriginUser extends MessageForwardOrigin {
  String get tdType => 'messageForwardOriginUser';

  string? extra;
  int? client_id;
  int53? sender_user_id;

  MessageForwardOriginUser({
    this.extra,
    this.client_id,
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
class MessageForwardOriginChat extends MessageForwardOrigin {
  String get tdType => 'messageForwardOriginChat';

  string? extra;
  int? client_id;
  int53? sender_chat_id;
  string? author_signature;

  MessageForwardOriginChat({
    this.extra,
    this.client_id,
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
class MessageForwardOriginHiddenUser extends MessageForwardOrigin {
  String get tdType => 'messageForwardOriginHiddenUser';

  string? extra;
  int? client_id;
  string? sender_name;

  MessageForwardOriginHiddenUser({
    this.extra,
    this.client_id,
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
class MessageForwardOriginChannel extends MessageForwardOrigin {
  String get tdType => 'messageForwardOriginChannel';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? message_id;
  string? author_signature;

  MessageForwardOriginChannel({
    this.extra,
    this.client_id,
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
class MessageForwardOriginMessageImport extends MessageForwardOrigin {
  String get tdType => 'messageForwardOriginMessageImport';

  string? extra;
  int? client_id;
  string? sender_name;

  MessageForwardOriginMessageImport({
    this.extra,
    this.client_id,
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
