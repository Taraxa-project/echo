import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/reaction_type.dart';


/// Adds a reaction to a message. Use getMessageAvailableReactions to receive the list of available reactions for the message
class AddMessageReaction extends TdFunction {
  String get tdType => 'addMessageReaction';
  String get tdReturnType => 'Ok';


  /// Identifier of the chat to which the message belongs
  int53? chat_id;

  /// Identifier of the message
  int53? message_id;

  /// Type of the reaction to add
  ReactionType? reaction_type;

  /// Pass true if the reaction is added with a big animation
  Bool? is_big;

  /// Pass true if the reaction needs to be added to recent reactions
  Bool? update_recent_reactions;

  AddMessageReaction({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_id,
    this.reaction_type,
    this.is_big,
    this.update_recent_reactions,
  });

  AddMessageReaction.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    if (map['reaction_type'] != null) {
      reaction_type = TdApiMap.fromMap(map['reaction_type']) as ReactionType;
    }
    is_big = map['is_big'];
    update_recent_reactions = map['update_recent_reactions'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'reaction_type': reaction_type?.toMap(skipNulls: skipNulls),
      'is_big': is_big?.toMap(skipNulls: skipNulls),
      'update_recent_reactions': update_recent_reactions?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
