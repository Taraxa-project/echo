import 'package:td_json_client/api/base.dart';


/// Marks all reactions in a chat or a forum topic as read 
class ReadAllChatReactions extends TdFunction {
  String get tdType => 'readAllChatReactions';
  String get tdReturnType => 'Ok';


  /// Chat identifier
  int53? chat_id;

  ReadAllChatReactions({
    super.extra,
    super.client_id,
    this.chat_id,
  });

  ReadAllChatReactions.fromMap(Map<String, dynamic> map) {
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
