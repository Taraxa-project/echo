import 'package:td_json_client/api/base.dart';

abstract class MessageSender extends TdObject {}

class MessageSenderUser extends MessageSender {
  String get tdType => 'messageSenderUser';

  String? extra;
  int? client_id;
  int53? user_id;

  MessageSenderUser({
    this.extra,
    this.client_id,
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
class MessageSenderChat extends MessageSender {
  String get tdType => 'messageSenderChat';

  String? extra;
  int? client_id;
  int53? chat_id;

  MessageSenderChat({
    this.extra,
    this.client_id,
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
