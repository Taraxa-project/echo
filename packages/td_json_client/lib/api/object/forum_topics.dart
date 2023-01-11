import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/forum_topic.dart';


/// Describes a list of forum topics
class ForumTopics extends TdObject {
  String get tdType => 'forumTopics';


  /// Approximate total number of forum topics found
  int32? total_count;

  /// List of forum topics
  vector<ForumTopic>? topics;

  /// Offset date for the next getForumTopics request
  int32? next_offset_date;

  /// Offset message identifier for the next getForumTopics request
  int53? next_offset_message_id;

  /// Offset message thread identifier for the next getForumTopics request
  int53? next_offset_message_thread_id;

  ForumTopics({
    super.extra,
    super.client_id,
    this.total_count,
    this.topics,
    this.next_offset_date,
    this.next_offset_message_id,
    this.next_offset_message_thread_id,
  });

  ForumTopics.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_count = map['total_count'];
    if (map['topics'] != null) {
      topics = [];
      for (var someValue in map['topics']) {
        if (someValue != null) {
          topics?.add(TdApiMap.fromMap(someValue) as ForumTopic);
        }
      }
    }
    next_offset_date = map['next_offset_date'];
    next_offset_message_id = map['next_offset_message_id'];
    next_offset_message_thread_id = map['next_offset_message_thread_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'total_count': total_count?.toMap(skipNulls: skipNulls),
      'topics': topics?.toMap(skipNulls: skipNulls),
      'next_offset_date': next_offset_date?.toMap(skipNulls: skipNulls),
      'next_offset_message_id': next_offset_message_id?.toMap(skipNulls: skipNulls),
      'next_offset_message_thread_id': next_offset_message_thread_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
