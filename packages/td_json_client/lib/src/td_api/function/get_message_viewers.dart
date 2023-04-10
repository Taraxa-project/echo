import 'package:td_json_client/src/td_api/td.dart';

/// Returns viewers of a recent outgoing message in a basic group or a supergroup chat. For video notes and voice notes only users, opened content of the message, are returned. The method can be called if message.can_get_viewers == true
class GetMessageViewers extends TdFunction {
  String get tdType => 'getMessageViewers';
  String get tdReturnType => 'Users';

  /// Chat identifier
  int53? chat_id;

  /// Identifier of the message
  int53? message_id;

  GetMessageViewers({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_id,
  });

  GetMessageViewers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
