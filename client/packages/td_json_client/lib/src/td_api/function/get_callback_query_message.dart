import 'package:td_json_client/src/td_api/td.dart';

/// Returns information about a message with the callback button that originated a callback query; for bots only
class GetCallbackQueryMessage extends TdFunction {
  String get tdType => 'getCallbackQueryMessage';
  String get tdReturnType => 'Message';

  /// Identifier of the chat the message belongs to
  int53? chat_id;

  /// Message identifier
  int53? message_id;

  /// Identifier of the callback query
  int64? callback_query_id;

  GetCallbackQueryMessage({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_id,
    this.callback_query_id,
  });

  GetCallbackQueryMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    callback_query_id = map['callback_query_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'callback_query_id': callback_query_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
