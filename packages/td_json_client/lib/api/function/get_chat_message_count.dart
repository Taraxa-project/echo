import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/search_messages_filter.dart';

class GetChatMessageCount extends TdFunction {
  String get tdType => 'getChatMessageCount';
  String get tdReturnType => 'Count';

  string? extra;
  int? client_id;
  int53? chat_id;
  SearchMessagesFilter? filter;
  Bool? return_local;

  GetChatMessageCount({
    this.extra,
    this.client_id,
    this.chat_id,
    this.filter,
    this.return_local,
  });

  GetChatMessageCount.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    filter = TdApiMap.fromMap(map['filter']) as SearchMessagesFilter;
    return_local = map['return_local'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'filter': filter?.toMap(skipNulls: skipNulls),
      'return_local': return_local?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
