import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/story_list.dart';

/// Changes story list in which stories from the chat are shown
class SetChatActiveStoriesList extends TdFunction {
  String get tdType => 'setChatActiveStoriesList';
  String get tdReturnType => 'Ok';

  /// Identifier of the chat that posted stories
  int53? chat_id;

  /// New list for active stories posted by the chat
  StoryList? story_list;

  SetChatActiveStoriesList({
    super.extra,
    super.client_id,
    this.chat_id,
    this.story_list,
  });

  SetChatActiveStoriesList.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['story_list'] != null) {
      story_list = TdApiMap.fromMap(map['story_list']) as StoryList;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'story_list': story_list?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
