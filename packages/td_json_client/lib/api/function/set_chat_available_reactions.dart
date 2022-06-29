import 'package:td_json_client/api/base.dart';


/// Changes reactions, available in a chat. Available for basic groups, supergroups, and channels. Requires can_change_info administrator right 
class SetChatAvailableReactions extends TdFunction {
  String get tdType => 'setChatAvailableReactions';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Identifier of the chat 
  int53? chat_id;

  /// New list of reactions, available in the chat. All reactions must be active
  vector<string>? available_reactions;

  SetChatAvailableReactions({
    this.extra,
    this.client_id,
    this.chat_id,
    this.available_reactions,
  });

  SetChatAvailableReactions.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['available_reactions'] != null) {
      available_reactions = [];
      for (var someValue in map['available_reactions']) {
        available_reactions?.add(someValue);
      }
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
