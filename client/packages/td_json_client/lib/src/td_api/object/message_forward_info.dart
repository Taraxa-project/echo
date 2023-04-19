import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/message_forward_origin.dart';

/// Contains information about a forwarded message
class MessageForwardInfo extends TdObject {
  String get tdType => 'messageForwardInfo';

  /// Origin of a forwarded message
  MessageForwardOrigin? origin;

  /// Point in time (Unix timestamp) when the message was originally sent
  int32? date;

  /// The type of a public service announcement for the forwarded message
  string? public_service_announcement_type;

  /// For messages forwarded to the chat with the current user (Saved Messages), to the Replies bot chat, or to the channel's discussion group, the identifier of the chat from which the message was forwarded last time; 0 if unknown
  int53? from_chat_id;

  /// For messages forwarded to the chat with the current user (Saved Messages), to the Replies bot chat, or to the channel's discussion group, the identifier of the original message from which the new message was forwarded last time; 0 if unknown
  int53? from_message_id;

  MessageForwardInfo({
    super.extra,
    super.client_id,
    this.origin,
    this.date,
    this.public_service_announcement_type,
    this.from_chat_id,
    this.from_message_id,
  });

  MessageForwardInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['origin'] != null) {
      origin = TdApiMap.fromMap(map['origin']) as MessageForwardOrigin;
    }
    date = map['date'];
    public_service_announcement_type = map['public_service_announcement_type'];
    from_chat_id = map['from_chat_id'];
    from_message_id = map['from_message_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'origin': origin?.toMap(skipNulls: skipNulls),
      'date': date?.toMap(skipNulls: skipNulls),
      'public_service_announcement_type': public_service_announcement_type?.toMap(skipNulls: skipNulls),
      'from_chat_id': from_chat_id?.toMap(skipNulls: skipNulls),
      'from_message_id': from_message_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
