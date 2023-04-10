import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/message_sender.dart';

/// Represents a message sender, which can be used to send messages in a chat
class ChatMessageSender extends TdObject {
  String get tdType => 'chatMessageSender';

  /// Available message senders
  MessageSender? sender;

  /// True, if Telegram Premium is needed to use the message sender
  Bool? needs_premium;

  ChatMessageSender({
    super.extra,
    super.client_id,
    this.sender,
    this.needs_premium,
  });

  ChatMessageSender.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sender'] != null) {
      sender = TdApiMap.fromMap(map['sender']) as MessageSender;
    }
    needs_premium = map['needs_premium'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sender': sender?.toMap(skipNulls: skipNulls),
      'needs_premium': needs_premium?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
