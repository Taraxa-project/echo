import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/input_story_content.dart';
import 'package:td_json_client/src/td_api/object/formatted_text.dart';

/// Changes content and caption of a previously sent story
class EditStory extends TdFunction {
  String get tdType => 'editStory';
  String get tdReturnType => 'Ok';

  /// Identifier of the story to edit
  int32? story_id;

  /// New content of the story; pass null to keep the current content
  InputStoryContent? content;

  /// New story caption; pass null to keep the current caption
  FormattedText? caption;

  EditStory({
    super.extra,
    super.client_id,
    this.story_id,
    this.content,
    this.caption,
  });

  EditStory.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    story_id = map['story_id'];
    if (map['content'] != null) {
      content = TdApiMap.fromMap(map['content']) as InputStoryContent;
    }
    if (map['caption'] != null) {
      caption = TdApiMap.fromMap(map['caption']) as FormattedText;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'story_id': story_id?.toMap(skipNulls: skipNulls),
      'content': content?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
