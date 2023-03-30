import 'package:td_json_client/src/td_api/td.dart';

/// Changes the ability of users to save, forward, or copy chat content. Supported only for basic groups, supergroups and channels. Requires owner privileges
class ToggleChatHasProtectedContent extends TdFunction {
  String get tdType => 'toggleChatHasProtectedContent';
  String get tdReturnType => 'Ok';

  /// Chat identifier
  int53? chat_id;

  /// New value of has_protected_content
  Bool? has_protected_content;

  ToggleChatHasProtectedContent({
    super.extra,
    super.client_id,
    this.chat_id,
    this.has_protected_content,
  });

  ToggleChatHasProtectedContent.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    has_protected_content = map['has_protected_content'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'has_protected_content':
          has_protected_content?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
