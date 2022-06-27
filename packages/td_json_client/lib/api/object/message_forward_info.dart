import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_forward_origin.dart';

class MessageForwardInfo extends TdObject {
  String get tdType => 'messageForwardInfo';

  String? extra;
  int? client_id;
  MessageForwardOrigin? origin;
  int32? date;
  string? public_service_announcement_type;
  int53? from_chat_id;
  int53? from_message_id;

  MessageForwardInfo({
    this.extra,
    this.client_id,
    this.origin,
    this.date,
    this.public_service_announcement_type,
    this.from_chat_id,
    this.from_message_id,
  });

  MessageForwardInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    origin = TdApiMap.fromMap(map['origin']) as MessageForwardOrigin;
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
