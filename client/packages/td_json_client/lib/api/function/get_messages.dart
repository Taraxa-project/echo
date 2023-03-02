import 'package:td_json_client/api/base.dart';


/// Returns information about messages. If a message is not found, returns null on the corresponding position of the result 
class GetMessages extends TdFunction {
  String get tdType => 'getMessages';
  String get tdReturnType => 'Messages';


  /// Identifier of the chat the messages belong to 
  int53? chat_id;

  /// Identifiers of the messages to get
  vector<int53>? message_ids;

  GetMessages({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_ids,
  });

  GetMessages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['message_ids'] != null) {
      message_ids = [];
      for (var someValue in map['message_ids']) {
        message_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_ids': message_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
