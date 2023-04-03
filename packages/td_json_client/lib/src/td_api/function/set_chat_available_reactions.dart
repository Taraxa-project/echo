import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_available_reactions.dart';

/// Changes reactions, available in a chat. Available for basic groups, supergroups, and channels. Requires can_change_info administrator right
class SetChatAvailableReactions extends TdFunction {
  String get tdType => 'setChatAvailableReactions';
  String get tdReturnType => 'Ok';

  /// Identifier of the chat
  int53? chat_id;

  /// Reactions available in the chat. All emoji reactions must be active
  ChatAvailableReactions? available_reactions;

  SetChatAvailableReactions({
    super.extra,
    super.client_id,
    this.chat_id,
    this.available_reactions,
  });

  SetChatAvailableReactions.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['available_reactions'] != null) {
      available_reactions = TdApiMap.fromMap(map['available_reactions']) as ChatAvailableReactions;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'available_reactions': available_reactions?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
