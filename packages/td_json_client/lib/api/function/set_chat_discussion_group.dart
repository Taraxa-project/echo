import 'package:td_json_client/api/base.dart';

class SetChatDiscussionGroup extends TdFunction {
  String get tdType => 'setChatDiscussionGroup';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  int53? chat_id;
  int53? discussion_chat_id;

  SetChatDiscussionGroup({
    this.extra,
    this.client_id,
    this.chat_id,
    this.discussion_chat_id,
  });

  SetChatDiscussionGroup.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    discussion_chat_id = map['discussion_chat_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'discussion_chat_id': discussion_chat_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
