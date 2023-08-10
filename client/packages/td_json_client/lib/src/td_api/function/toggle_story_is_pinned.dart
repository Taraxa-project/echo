import 'package:td_json_client/src/td_api/td.dart';

/// Toggles whether a story is accessible after expiration
class ToggleStoryIsPinned extends TdFunction {
  String get tdType => 'toggleStoryIsPinned';
  String get tdReturnType => 'Ok';

  /// Identifier of the story
  int32? story_id;

  /// Pass true to make the story accessible after expiration; pass false to make it private
  Bool? is_pinned;

  ToggleStoryIsPinned({
    super.extra,
    super.client_id,
    this.story_id,
    this.is_pinned,
  });

  ToggleStoryIsPinned.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    story_id = map['story_id'];
    is_pinned = map['is_pinned'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'story_id': story_id?.toMap(skipNulls: skipNulls),
      'is_pinned': is_pinned?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
