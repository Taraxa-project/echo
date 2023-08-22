import 'package:td_json_client/src/td_api/td.dart';

/// Returns a story
class GetStory extends TdFunction {
  String get tdType => 'getStory';
  String get tdReturnType => 'Story';

  /// Identifier of the chat that posted the story
  int53? story_sender_chat_id;

  /// Story identifier
  int32? story_id;

  /// Pass true to get only locally available information without sending network requests
  Bool? only_local;

  GetStory({
    super.extra,
    super.client_id,
    this.story_sender_chat_id,
    this.story_id,
    this.only_local,
  });

  GetStory.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    story_sender_chat_id = map['story_sender_chat_id'];
    story_id = map['story_id'];
    only_local = map['only_local'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'story_sender_chat_id': story_sender_chat_id?.toMap(skipNulls: skipNulls),
      'story_id': story_id?.toMap(skipNulls: skipNulls),
      'only_local': only_local?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
