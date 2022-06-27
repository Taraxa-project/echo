import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/location.dart';

class GetInlineQueryResults extends TdFunction {
  String get tdType => 'getInlineQueryResults';
  String get tdReturnType => 'InlineQueryResults';

  string? extra;
  int? client_id;
  int53? bot_user_id;
  int53? chat_id;
  Location? user_location;
  string? query;
  string? offset;

  GetInlineQueryResults({
    this.extra,
    this.client_id,
    this.bot_user_id,
    this.chat_id,
    this.user_location,
    this.query,
    this.offset,
  });

  GetInlineQueryResults.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_user_id = map['bot_user_id'];
    chat_id = map['chat_id'];
    user_location = TdApiMap.fromMap(map['user_location']) as Location;
    query = map['query'];
    offset = map['offset'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bot_user_id': bot_user_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'user_location': user_location?.toMap(skipNulls: skipNulls),
      'query': query?.toMap(skipNulls: skipNulls),
      'offset': offset?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
