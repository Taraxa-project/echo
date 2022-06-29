import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/location.dart';


/// Sends an inline query to a bot and returns its results. Returns an error with code 502 if the bot fails to answer the query before the query timeout expires
class GetInlineQueryResults extends TdFunction {
  String get tdType => 'getInlineQueryResults';
  String get tdReturnType => 'InlineQueryResults';

  String? extra;
  int? client_id;

  /// The identifier of the target bot
  int53? bot_user_id;

  /// Identifier of the chat where the query was sent
  int53? chat_id;

  /// Location of the user; pass null if unknown or the bot doesn't need user's location
  Location? user_location;

  /// Text of the query
  string? query;

  /// Offset of the first entry to return
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
    if (map['user_location'] != null) {
      user_location = TdApiMap.fromMap(map['user_location']) as Location;
    }
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
