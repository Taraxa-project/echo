import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';


/// Contains information about a reaction to a message
class MessageReaction extends TdObject {
  String get tdType => 'messageReaction';

  String? extra;
  int? client_id;

  /// Text representation of the reaction
  string? reaction;

  /// Number of times the reaction was added
  int32? total_count;

  /// True, if the reaction is chosen by the current user
  Bool? is_chosen;

  /// Identifiers of at most 3 recent message senders, added the reaction; available in private, basic group and supergroup chats
  vector<MessageSender>? recent_sender_ids;

  MessageReaction({
    this.extra,
    this.client_id,
    this.reaction,
    this.total_count,
    this.is_chosen,
    this.recent_sender_ids,
  });

  MessageReaction.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    reaction = map['reaction'];
    total_count = map['total_count'];
    is_chosen = map['is_chosen'];
    if (map['recent_sender_ids'] != null) {
      recent_sender_ids = [];
      for (var someValue in map['recent_sender_ids']) {
        if (someValue != null) {
          recent_sender_ids?.add(TdApiMap.fromMap(someValue) as MessageSender);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'reaction': reaction?.toMap(skipNulls: skipNulls),
      'total_count': total_count?.toMap(skipNulls: skipNulls),
      'is_chosen': is_chosen?.toMap(skipNulls: skipNulls),
      'recent_sender_ids': recent_sender_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
