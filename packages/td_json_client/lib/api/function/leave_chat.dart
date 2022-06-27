import 'package:td_json_client/api/base.dart';


/// Removes the current user from chat members. Private and secret chats can't be left using this method 
class LeaveChat extends TdFunction {
  String get tdType => 'leaveChat';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Chat identifier
  int53? chat_id;

  LeaveChat({
    this.extra,
    this.client_id,
    this.chat_id,
  });

  LeaveChat.fromMap(Map<String, dynamic> map) {
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
