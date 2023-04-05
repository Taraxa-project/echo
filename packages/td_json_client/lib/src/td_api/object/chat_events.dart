import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_event.dart';

/// Contains a list of chat events
class ChatEvents extends TdObject {
  String get tdType => 'chatEvents';

  /// List of events
  vector<ChatEvent>? events;

  ChatEvents({
    super.extra,
    super.client_id,
    this.events,
  });

  ChatEvents.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['events'] != null) {
      events = [];
      for (var someValue in map['events']) {
        if (someValue != null) {
          events?.add(TdApiMap.fromMap(someValue) as ChatEvent);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'events': events?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
