import 'package:td_json_client/api/base.dart';


/// Invites a bot to a chat (if it is not yet a member) and sends it the /start command. Bots can't be invited to a private chat other than the chat with the bot. Bots can't be invited to channels (although they can be added as admins) and secret chats. Returns the sent message
class SendBotStartMessage extends TdFunction {
  String get tdType => 'sendBotStartMessage';
  String get tdReturnType => 'Message';

  String? extra;
  int? client_id;

  /// Identifier of the bot 
  int53? bot_user_id;

  /// Identifier of the target chat 
  int53? chat_id;

  /// A hidden parameter sent to the bot for deep linking purposes (https://core.telegram.org/bots#deep-linking)
  string? parameter;

  SendBotStartMessage({
    this.extra,
    this.client_id,
    this.bot_user_id,
    this.chat_id,
    this.parameter,
  });

  SendBotStartMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_user_id = map['bot_user_id'];
    chat_id = map['chat_id'];
    parameter = map['parameter'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bot_user_id': bot_user_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'parameter': parameter?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
