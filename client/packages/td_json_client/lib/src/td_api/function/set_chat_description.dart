import 'package:td_json_client/src/td_api/td.dart';

/// Changes information about a chat. Available for basic groups, supergroups, and channels. Requires can_change_info administrator right
class SetChatDescription extends TdFunction {
  String get tdType => 'setChatDescription';
  String get tdReturnType => 'Ok';

  /// Identifier of the chat
  int53? chat_id;

  string? description;

  SetChatDescription({
    super.extra,
    super.client_id,
    this.chat_id,
    this.description,
  });

  SetChatDescription.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    description = map['description'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'description': description?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
