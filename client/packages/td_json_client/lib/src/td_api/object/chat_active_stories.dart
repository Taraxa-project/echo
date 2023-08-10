import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/story_list.dart';
import 'package:td_json_client/src/td_api/object/story_info.dart';

/// Describes active stories posted by a chat
class ChatActiveStories extends TdObject {
  String get tdType => 'chatActiveStories';

  /// Identifier of the chat that posted the stories
  int53? chat_id;

  /// Identifier of the story list in which the stories are shown; may be null if the stories aren't shown in a story list
  StoryList? list;

  /// A parameter used to determine order of the stories in the story list; 0 if the stories doesn't need to be shown in the story list. Stories must be sorted by the pair (order, story_sender_chat_id) in descending order
  int53? order;

  /// Identifier of the last read active story
  int32? max_read_story_id;

  /// Basic information about the stories; use getStory to get full information about the stories. The stories are in a chronological order (i.e., in order of increasing story identifiers)
  vector<StoryInfo>? stories;

  ChatActiveStories({
    super.extra,
    super.client_id,
    this.chat_id,
    this.list,
    this.order,
    this.max_read_story_id,
    this.stories,
  });

  ChatActiveStories.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['list'] != null) {
      list = TdApiMap.fromMap(map['list']) as StoryList;
    }
    order = map['order'];
    max_read_story_id = map['max_read_story_id'];
    if (map['stories'] != null) {
      stories = [];
      for (var someValue in map['stories']) {
        if (someValue != null) {
          stories?.add(TdApiMap.fromMap(someValue) as StoryInfo);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'list': list?.toMap(skipNulls: skipNulls),
      'order': order?.toMap(skipNulls: skipNulls),
      'max_read_story_id': max_read_story_id?.toMap(skipNulls: skipNulls),
      'stories': stories?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
