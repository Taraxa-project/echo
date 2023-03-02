import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/forum_topic_icon.dart';


/// Creates a topic in a forum supergroup chat; requires can_manage_topics rights in the supergroup
class CreateForumTopic extends TdFunction {
  String get tdType => 'createForumTopic';
  String get tdReturnType => 'ForumTopicInfo';


  /// Identifier of the chat
  int53? chat_id;

  /// Name of the topic; 1-128 characters
  string? name;

  /// Icon of the topic. Icon color must be one of 0x6FB9F0, 0xFFD67E, 0xCB86DB, 0x8EEE98, 0xFF93B2, or 0xFB6F5F. Telegram Premium users can use any custom emoji as topic icon, other users can use only a custom emoji returned by getForumTopicDefaultIcons
  ForumTopicIcon? icon;

  CreateForumTopic({
    super.extra,
    super.client_id,
    this.chat_id,
    this.name,
    this.icon,
  });

  CreateForumTopic.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    name = map['name'];
    if (map['icon'] != null) {
      icon = TdApiMap.fromMap(map['icon']) as ForumTopicIcon;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
      'icon': icon?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
