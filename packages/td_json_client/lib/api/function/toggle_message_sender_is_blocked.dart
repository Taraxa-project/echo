import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';

class ToggleMessageSenderIsBlocked extends TdFunction {
  String get tdType => 'toggleMessageSenderIsBlocked';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  MessageSender? sender_id;
  Bool? is_blocked;

  ToggleMessageSenderIsBlocked({
    this.extra,
    this.client_id,
    this.sender_id,
    this.is_blocked,
  });

  ToggleMessageSenderIsBlocked.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    sender_id = TdApiMap.fromMap(map['sender_id']) as MessageSender;
    is_blocked = map['is_blocked'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sender_id': sender_id?.toMap(skipNulls: skipNulls),
      'is_blocked': is_blocked?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
