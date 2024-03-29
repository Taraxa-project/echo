import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/message_sender.dart';

/// Changes the block state of a message sender. Currently, only users and supergroup chats can be blocked
class ToggleMessageSenderIsBlocked extends TdFunction {
  String get tdType => 'toggleMessageSenderIsBlocked';
  String get tdReturnType => 'Ok';

  /// Identifier of a message sender to block/unblock
  MessageSender? sender_id;

  /// New value of is_blocked
  Bool? is_blocked;

  ToggleMessageSenderIsBlocked({
    super.extra,
    super.client_id,
    this.sender_id,
    this.is_blocked,
  });

  ToggleMessageSenderIsBlocked.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sender_id'] != null) {
      sender_id = TdApiMap.fromMap(map['sender_id']) as MessageSender;
    }
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
