import 'package:td_json_client/api/base.dart';


/// Pins a message in a chat; requires can_pin_messages rights or can_edit_messages rights in the channel
class PinChatMessage extends TdFunction {
  String get tdType => 'pinChatMessage';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Identifier of the chat
  int53? chat_id;

  /// Identifier of the new pinned message
  int53? message_id;

  /// Pass true to disable notification about the pinned message. Notifications are always disabled in channels and private chats
  Bool? disable_notification;

  /// Pass true to pin the message only for self; private chats only
  Bool? only_for_self;

  PinChatMessage({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_id,
    this.disable_notification,
    this.only_for_self,
  });

  PinChatMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    disable_notification = map['disable_notification'];
    only_for_self = map['only_for_self'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'disable_notification': disable_notification?.toMap(skipNulls: skipNulls),
      'only_for_self': only_for_self?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
