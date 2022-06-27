import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';

class AddedReaction extends TdObject {
  String get tdType => 'addedReaction';

  string? extra;
  int? client_id;
  string? reaction;
  MessageSender? sender_id;

  AddedReaction({
    this.extra,
    this.client_id,
    this.reaction,
    this.sender_id,
  });

  AddedReaction.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    reaction = map['reaction'];
    sender_id = TdApiMap.fromMap(map['sender_id']) as MessageSender;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'reaction': reaction?.toMap(skipNulls: skipNulls),
      'sender_id': sender_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
