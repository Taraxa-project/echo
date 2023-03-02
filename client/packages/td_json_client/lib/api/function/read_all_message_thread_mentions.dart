import 'package:td_json_client/api/base.dart';


/// Marks all mentions in a forum topic as read 
class ReadAllMessageThreadMentions extends TdFunction {
  String get tdType => 'readAllMessageThreadMentions';
  String get tdReturnType => 'Ok';


  /// Chat identifier 
  int53? chat_id;

  /// Message thread identifier in which mentions are marked as read
  int53? message_thread_id;

  ReadAllMessageThreadMentions({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_thread_id,
  });

  ReadAllMessageThreadMentions.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_thread_id = map['message_thread_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_thread_id': message_thread_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
