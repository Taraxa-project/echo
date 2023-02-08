import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/reaction_type.dart';

/// Returns reactions added for a message, along with their sender
class GetMessageAddedReactions extends TdFunction {
  String get tdType => 'getMessageAddedReactions';
  String get tdReturnType => 'AddedReactions';

  /// Identifier of the chat to which the message belongs
  int53? chat_id;

  /// Identifier of the message
  int53? message_id;

  /// Type of the reactions to return; pass null to return all added reactions
  ReactionType? reaction_type;

  /// Offset of the first entry to return as received from the previous request; use empty string to get the first chunk of results
  string? offset;

  /// The maximum number of reactions to be returned; must be positive and can't be greater than 100
  int32? limit;

  GetMessageAddedReactions({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_id,
    this.reaction_type,
    this.offset,
    this.limit,
  });

  GetMessageAddedReactions.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    if (map['reaction_type'] != null) {
      reaction_type = TdApiMap.fromMap(map['reaction_type']) as ReactionType;
    }
    offset = map['offset'];
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'reaction_type': reaction_type?.toMap(skipNulls: skipNulls),
      'offset': offset?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
