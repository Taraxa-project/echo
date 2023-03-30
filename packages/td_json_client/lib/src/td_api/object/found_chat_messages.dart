import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/message.dart';

/// Contains a list of messages found by a search in a given chat
class FoundChatMessages extends TdObject {
  String get tdType => 'foundChatMessages';

  /// Approximate total number of messages found; -1 if unknown
  int32? total_count;

  /// List of messages
  vector<Message>? messages;

  /// The offset for the next request. If 0, there are no more results
  int53? next_from_message_id;

  FoundChatMessages({
    super.extra,
    super.client_id,
    this.total_count,
    this.messages,
    this.next_from_message_id,
  });

  FoundChatMessages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_count = map['total_count'];
    if (map['messages'] != null) {
      messages = [];
      for (var someValue in map['messages']) {
        if (someValue != null) {
          messages?.add(TdApiMap.fromMap(someValue) as Message);
        }
      }
    }
    next_from_message_id = map['next_from_message_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'total_count': total_count?.toMap(skipNulls: skipNulls),
      'messages': messages?.toMap(skipNulls: skipNulls),
      'next_from_message_id': next_from_message_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
