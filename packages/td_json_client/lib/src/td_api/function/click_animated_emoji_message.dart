import 'package:td_json_client/src/td_api/td.dart';

/// Informs TDLib that a message with an animated emoji was clicked by the user. Returns a big animated sticker to be played or a 404 error if usual animation needs to be played
class ClickAnimatedEmojiMessage extends TdFunction {
  String get tdType => 'clickAnimatedEmojiMessage';
  String get tdReturnType => 'Sticker';

  /// Chat identifier of the message
  int53? chat_id;

  /// Identifier of the clicked message
  int53? message_id;

  ClickAnimatedEmojiMessage({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_id,
  });

  ClickAnimatedEmojiMessage.fromMap(Map<String, dynamic> map) {
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
