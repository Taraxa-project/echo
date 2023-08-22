import 'package:td_json_client/src/td_api/td.dart';

/// Contains basic information about a story
class StoryInfo extends TdObject {
  String get tdType => 'storyInfo';

  /// Unique story identifier among stories of the given sender
  int32? story_id;

  /// Point in time (Unix timestamp) when the story was published
  int32? date;

  /// True, if the story is available only to close friends
  Bool? is_for_close_friends;

  StoryInfo({
    super.extra,
    super.client_id,
    this.story_id,
    this.date,
    this.is_for_close_friends,
  });

  StoryInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    story_id = map['story_id'];
    date = map['date'];
    is_for_close_friends = map['is_for_close_friends'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'story_id': story_id?.toMap(skipNulls: skipNulls),
      'date': date?.toMap(skipNulls: skipNulls),
      'is_for_close_friends': is_for_close_friends?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
