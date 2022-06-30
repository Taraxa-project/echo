import 'package:td_json_client/api/base.dart';


/// Sends a notification about a screenshot taken in a chat. Supported only in private and secret chats 
class SendChatScreenshotTakenNotification extends TdFunction {
  String get tdType => 'sendChatScreenshotTakenNotification';
  String get tdReturnType => 'Ok';


  /// Chat identifier
  int53? chat_id;

  SendChatScreenshotTakenNotification({
    super.extra,
    super.client_id,
    this.chat_id,
  });

  SendChatScreenshotTakenNotification.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
