import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/forum_topic_icon.dart';
import 'package:td_json_client/src/td_api/object/message_sender.dart';

/// Contains basic information about a forum topic
class ForumTopicInfo extends TdObject {
  String get tdType => 'forumTopicInfo';

  /// Message thread identifier of the topic
  int53? message_thread_id;

  /// Name of the topic
  string? name;

  /// Icon of the topic
  ForumTopicIcon? icon;

  /// Date the topic was created
  int32? creation_date;

  /// Identifier of the creator of the topic
  MessageSender? creator_id;

  /// True, if the topic is the General topic list
  Bool? is_general;

  /// True, if the topic was created by the current user
  Bool? is_outgoing;

  /// True, if the topic is closed
  Bool? is_closed;

  /// True, if the topic is hidden above the topic list and closed; for General topic only
  Bool? is_hidden;

  ForumTopicInfo({
    super.extra,
    super.client_id,
    this.message_thread_id,
    this.name,
    this.icon,
    this.creation_date,
    this.creator_id,
    this.is_general,
    this.is_outgoing,
    this.is_closed,
    this.is_hidden,
  });

  ForumTopicInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    message_thread_id = map['message_thread_id'];
    name = map['name'];
    if (map['icon'] != null) {
      icon = TdApiMap.fromMap(map['icon']) as ForumTopicIcon;
    }
    creation_date = map['creation_date'];
    if (map['creator_id'] != null) {
      creator_id = TdApiMap.fromMap(map['creator_id']) as MessageSender;
    }
    is_general = map['is_general'];
    is_outgoing = map['is_outgoing'];
    is_closed = map['is_closed'];
    is_hidden = map['is_hidden'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'message_thread_id': message_thread_id?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
      'icon': icon?.toMap(skipNulls: skipNulls),
      'creation_date': creation_date?.toMap(skipNulls: skipNulls),
      'creator_id': creator_id?.toMap(skipNulls: skipNulls),
      'is_general': is_general?.toMap(skipNulls: skipNulls),
      'is_outgoing': is_outgoing?.toMap(skipNulls: skipNulls),
      'is_closed': is_closed?.toMap(skipNulls: skipNulls),
      'is_hidden': is_hidden?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
