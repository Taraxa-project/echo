import 'package:td_json_client/src/td_api/td.dart';

/// Toggles whether a General topic is hidden in a forum supergroup chat; requires can_manage_topics administrator right in the supergroup
class ToggleGeneralForumTopicIsHidden extends TdFunction {
  String get tdType => 'toggleGeneralForumTopicIsHidden';
  String get tdReturnType => 'Ok';

  /// Identifier of the chat
  int53? chat_id;

  /// Pass true to hide and close the General topic; pass false to unhide it
  Bool? is_hidden;

  ToggleGeneralForumTopicIsHidden({
    super.extra,
    super.client_id,
    this.chat_id,
    this.is_hidden,
  });

  ToggleGeneralForumTopicIsHidden.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    is_hidden = map['is_hidden'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'is_hidden': is_hidden?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
