import 'package:td_json_client/src/td_api/td.dart';

/// Returns the list of pinned stories posted by the given chat. The stories are returned in a reverse chronological order (i.e., in order of decreasing story_id).
/// For optimal performance, the number of returned stories is chosen by TDLib
class GetChatPinnedStories extends TdFunction {
  String get tdType => 'getChatPinnedStories';
  String get tdReturnType => 'Stories';

  /// Chat identifier
  int53? chat_id;

  /// Identifier of the story starting from which stories must be returned; use 0 to get results from the last story
  int32? from_story_id;

  /// The maximum number of stories to be returned
  /// For optimal performance, the number of returned stories is chosen by TDLib and can be smaller than the specified limit
  int32? limit;

  GetChatPinnedStories({
    super.extra,
    super.client_id,
    this.chat_id,
    this.from_story_id,
    this.limit,
  });

  GetChatPinnedStories.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    from_story_id = map['from_story_id'];
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'from_story_id': from_story_id?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
