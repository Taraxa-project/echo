import 'package:td_json_client/api/base.dart';


/// Adds the current user as a new member to a chat. Private and secret chats can't be joined using this method 
class JoinChat extends TdFunction {
  String get tdType => 'joinChat';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Chat identifier
  int53? chat_id;

  JoinChat({
    this.extra,
    this.client_id,
    this.chat_id,
  });

  JoinChat.fromMap(Map<String, dynamic> map) {
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
