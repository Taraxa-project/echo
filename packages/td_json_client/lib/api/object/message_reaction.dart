import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';

class MessageReaction extends TdObject {
  String get tdType => 'messageReaction';

  string? extra;
  int? client_id;
  string? reaction;
  int32? total_count;
  Bool? is_chosen;
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
    if (map['recent_sender_ids']) {
      recent_sender_ids = [];
      for (var someValue in map['recent_sender_ids']) {
        recent_sender_ids?.add(TdApiMap.fromMap(someValue) as MessageSender);
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
