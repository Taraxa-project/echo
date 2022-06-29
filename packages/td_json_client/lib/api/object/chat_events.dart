import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_event.dart';


/// Contains a list of chat events 
class ChatEvents extends TdObject {
  String get tdType => 'chatEvents';

  String? extra;
  int? client_id;

  /// List of events
  vector<ChatEvent>? events;

  ChatEvents({
    this.extra,
    this.client_id,
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
