import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';
import 'package:td_json_client/api/object/chat_event_action.dart';

class ChatEvent extends TdObject {
  String get tdType => 'chatEvent';

  String? extra;
  int? client_id;
  int64? id;
  int32? date;
  MessageSender? member_id;
  ChatEventAction? action;

  ChatEvent({
    this.extra,
    this.client_id,
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
    member_id = TdApiMap.fromMap(map['member_id']) as MessageSender;
    action = TdApiMap.fromMap(map['action']) as ChatEventAction;
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
