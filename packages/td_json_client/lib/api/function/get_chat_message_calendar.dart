import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/search_messages_filter.dart';

class GetChatMessageCalendar extends TdFunction {
  String get tdType => 'getChatMessageCalendar';
  String get tdReturnType => 'MessageCalendar';

  string? extra;
  int? client_id;
  int53? chat_id;
  SearchMessagesFilter? filter;
  int53? from_message_id;

  GetChatMessageCalendar({
    this.extra,
    this.client_id,
    this.chat_id,
    this.filter,
    this.from_message_id,
  });

  GetChatMessageCalendar.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    filter = TdApiMap.fromMap(map['filter']) as SearchMessagesFilter;
    from_message_id = map['from_message_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'filter': filter?.toMap(skipNulls: skipNulls),
      'from_message_id': from_message_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
