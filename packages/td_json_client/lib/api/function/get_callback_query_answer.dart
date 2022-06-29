import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/callback_query_payload.dart';


/// Sends a callback query to a bot and returns an answer. Returns an error with code 502 if the bot fails to answer the query before the query timeout expires 
class GetCallbackQueryAnswer extends TdFunction {
  String get tdType => 'getCallbackQueryAnswer';
  String get tdReturnType => 'CallbackQueryAnswer';

  String? extra;
  int? client_id;

  /// Identifier of the chat with the message 
  int53? chat_id;

  /// Identifier of the message from which the query originated 
  int53? message_id;

  /// Query payload
  CallbackQueryPayload? payload;

  GetCallbackQueryAnswer({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_id,
    this.payload,
  });

  GetCallbackQueryAnswer.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    if (map['payload'] != null) {
      payload = TdApiMap.fromMap(map['payload']) as CallbackQueryPayload;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'payload': payload?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
