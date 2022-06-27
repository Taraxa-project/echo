import 'package:td_json_client/api/base.dart';

class ToggleChatIsMarkedAsUnread extends TdFunction {
  String get tdType => 'toggleChatIsMarkedAsUnread';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int53? chat_id;
  Bool? is_marked_as_unread;

  ToggleChatIsMarkedAsUnread({
    this.extra,
    this.client_id,
    this.chat_id,
    this.is_marked_as_unread,
  });

  ToggleChatIsMarkedAsUnread.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    is_marked_as_unread = map['is_marked_as_unread'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'is_marked_as_unread': is_marked_as_unread?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
