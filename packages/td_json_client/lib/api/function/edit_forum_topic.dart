import 'package:td_json_client/api/base.dart';


/// Edits title and icon of a topic in a forum supergroup chat; requires can_manage_topics administrator right in the supergroup unless the user is creator of the topic
class EditForumTopic extends TdFunction {
  String get tdType => 'editForumTopic';
  String get tdReturnType => 'Ok';


  /// Identifier of the chat
  int53? chat_id;

  /// Message thread identifier of the forum topic
  int53? message_thread_id;

  /// New name of the topic; 0-128 characters. If empty, the previous topic name is kept
  string? name;

  /// Pass true to edit the icon of the topic. Icon of the General topic can't be edited
  Bool? edit_icon_custom_emoji;

  /// Identifier of the new custom emoji for topic icon; pass 0 to remove the custom emoji. Ignored if edit_icon_custom_emoji is false. Telegram Premium users can use any custom emoji, other users can use only a custom emoji returned by getForumTopicDefaultIcons
  int64? icon_custom_emoji_id;

  EditForumTopic({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_thread_id,
    this.name,
    this.edit_icon_custom_emoji,
    this.icon_custom_emoji_id,
  });

  EditForumTopic.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_thread_id = map['message_thread_id'];
    name = map['name'];
    edit_icon_custom_emoji = map['edit_icon_custom_emoji'];
    icon_custom_emoji_id = map['icon_custom_emoji_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_thread_id': message_thread_id?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
      'edit_icon_custom_emoji': edit_icon_custom_emoji?.toMap(skipNulls: skipNulls),
      'icon_custom_emoji_id': icon_custom_emoji_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
