import 'package:td_json_client/api/base.dart';


/// Returns all scheduled messages in a chat. The messages are returned in a reverse chronological order (i.e., in order of decreasing message_id) 
class GetChatScheduledMessages extends TdFunction {
  String get tdType => 'getChatScheduledMessages';
  String get tdReturnType => 'Messages';

  String? extra;
  int? client_id;

  /// Chat identifier
  int53? chat_id;

  GetChatScheduledMessages({
    this.extra,
    this.client_id,
    this.chat_id,
  });

  GetChatScheduledMessages.fromMap(Map<String, dynamic> map) {
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
