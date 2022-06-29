import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';


/// Contains information about an unread reaction to a message
class UnreadReaction extends TdObject {
  String get tdType => 'unreadReaction';

  String? extra;
  int? client_id;

  /// Text representation of the reaction
  string? reaction;

  /// Identifier of the sender, added the reaction
  MessageSender? sender_id;

  /// True, if the reaction was added with a big animation
  Bool? is_big;

  UnreadReaction({
    this.extra,
    this.client_id,
    this.reaction,
    this.sender_id,
    this.is_big,
  });

  UnreadReaction.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    reaction = map['reaction'];
    if (map['sender_id'] != null) {
      sender_id = TdApiMap.fromMap(map['sender_id']) as MessageSender;
    }
    is_big = map['is_big'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'reaction': reaction?.toMap(skipNulls: skipNulls),
      'sender_id': sender_id?.toMap(skipNulls: skipNulls),
      'is_big': is_big?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
