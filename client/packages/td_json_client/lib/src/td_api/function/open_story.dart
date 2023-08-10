import 'package:td_json_client/src/td_api/td.dart';

/// Informs TDLib that a story is opened and is being viewed by the user
class OpenStory extends TdFunction {
  String get tdType => 'openStory';
  String get tdReturnType => 'Ok';

  /// The identifier of the sender of the opened story
  int53? story_sender_chat_id;

  /// The identifier of the story
  int32? story_id;

  OpenStory({
    super.extra,
    super.client_id,
    this.story_sender_chat_id,
    this.story_id,
  });

  OpenStory.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    story_sender_chat_id = map['story_sender_chat_id'];
    story_id = map['story_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'story_sender_chat_id': story_sender_chat_id?.toMap(skipNulls: skipNulls),
      'story_id': story_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
