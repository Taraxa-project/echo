import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/story_list.dart';

/// Loads more active stories from a story list. The loaded stories will be sent through updates. Active stories are sorted by
/// the pair (active_stories.order, active_stories.story_sender_chat_id) in descending order. Returns a 404 error if all active stories have been loaded
class LoadActiveStories extends TdFunction {
  String get tdType => 'loadActiveStories';
  String get tdReturnType => 'Ok';

  /// The story list in which to load active stories
  StoryList? story_list;

  LoadActiveStories({
    super.extra,
    super.client_id,
    this.story_list,
  });

  LoadActiveStories.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['story_list'] != null) {
      story_list = TdApiMap.fromMap(map['story_list']) as StoryList;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'story_list': story_list?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
