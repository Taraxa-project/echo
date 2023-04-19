import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_message_sender.dart';

/// Represents a list of message senders, which can be used to send messages in a chat
class ChatMessageSenders extends TdObject {
  String get tdType => 'chatMessageSenders';

  /// List of available message senders
  vector<ChatMessageSender>? senders;

  ChatMessageSenders({
    super.extra,
    super.client_id,
    this.senders,
  });

  ChatMessageSenders.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['senders'] != null) {
      senders = [];
      for (var someValue in map['senders']) {
        if (someValue != null) {
          senders?.add(TdApiMap.fromMap(someValue) as ChatMessageSender);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'senders': senders?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
