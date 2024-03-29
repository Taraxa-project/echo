import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/reaction_type.dart';
import 'package:td_json_client/src/td_api/object/message_sender.dart';

/// Represents a reaction applied to a message
class AddedReaction extends TdObject {
  String get tdType => 'addedReaction';

  /// Type of the reaction
  ReactionType? type;

  /// Identifier of the chat member, applied the reaction
  MessageSender? sender_id;

  /// Point in time (Unix timestamp) when the reaction was added
  int32? date;

  AddedReaction({
    super.extra,
    super.client_id,
    this.type,
    this.sender_id,
    this.date,
  });

  AddedReaction.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as ReactionType;
    }
    if (map['sender_id'] != null) {
      sender_id = TdApiMap.fromMap(map['sender_id']) as MessageSender;
    }
    date = map['date'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'sender_id': sender_id?.toMap(skipNulls: skipNulls),
      'date': date?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
