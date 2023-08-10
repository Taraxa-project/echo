import 'package:td_json_client/src/td_api/td.dart';

/// Contains information about interactions with a story
class StoryInteractionInfo extends TdObject {
  String get tdType => 'storyInteractionInfo';

  /// Number of times the story was viewed
  int32? view_count;

  /// Identifiers of at most 3 recent viewers of the story
  vector<int53>? recent_viewer_user_ids;

  StoryInteractionInfo({
    super.extra,
    super.client_id,
    this.view_count,
    this.recent_viewer_user_ids,
  });

  StoryInteractionInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    view_count = map['view_count'];
    if (map['recent_viewer_user_ids'] != null) {
      recent_viewer_user_ids = [];
      for (var someValue in map['recent_viewer_user_ids']) {
        recent_viewer_user_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'view_count': view_count?.toMap(skipNulls: skipNulls),
      'recent_viewer_user_ids': recent_viewer_user_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
