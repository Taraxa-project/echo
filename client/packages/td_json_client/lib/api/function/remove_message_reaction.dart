import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/reaction_type.dart';


/// Removes a reaction from a message. A chosen reaction can always be removed
class RemoveMessageReaction extends TdFunction {
  String get tdType => 'removeMessageReaction';
  String get tdReturnType => 'Ok';


  /// Identifier of the chat to which the message belongs
  int53? chat_id;

  /// Identifier of the message
  int53? message_id;

  /// Type of the reaction to remove
  ReactionType? reaction_type;

  RemoveMessageReaction({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_id,
    this.reaction_type,
  });

  RemoveMessageReaction.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    if (map['reaction_type'] != null) {
      reaction_type = TdApiMap.fromMap(map['reaction_type']) as ReactionType;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'reaction_type': reaction_type?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
