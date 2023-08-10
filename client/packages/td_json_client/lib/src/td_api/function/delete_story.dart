import 'package:td_json_client/src/td_api/td.dart';

/// Deletes a previously sent story
class DeleteStory extends TdFunction {
  String get tdType => 'deleteStory';
  String get tdReturnType => 'Ok';

  /// Identifier of the story to delete
  int32? story_id;

  DeleteStory({
    super.extra,
    super.client_id,
    this.story_id,
  });

  DeleteStory.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    story_id = map['story_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'story_id': story_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
