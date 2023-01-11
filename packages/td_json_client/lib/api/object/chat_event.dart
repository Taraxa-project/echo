import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';
import 'package:td_json_client/api/object/chat_event_action.dart';


/// Represents a chat event
class ChatEvent extends TdObject {
  String get tdType => 'chatEvent';


  /// Chat event identifier
  int64? id;

  /// Point in time (Unix timestamp) when the event happened
  int32? date;

  /// Identifier of the user or chat who performed the action
  MessageSender? member_id;

  /// The action
  ChatEventAction? action;

  ChatEvent({
    super.extra,
    super.client_id,
    this.id,
    this.date,
    this.member_id,
    this.action,
  });

  ChatEvent.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    date = map['date'];
    if (map['member_id'] != null) {
      member_id = TdApiMap.fromMap(map['member_id']) as MessageSender;
    }
    if (map['action'] != null) {
      action = TdApiMap.fromMap(map['action']) as ChatEventAction;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'date': date?.toMap(skipNulls: skipNulls),
      'member_id': member_id?.toMap(skipNulls: skipNulls),
      'action': action?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
