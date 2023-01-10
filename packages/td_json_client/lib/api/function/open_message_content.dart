import 'package:td_json_client/api/base.dart';


/// Informs TDLib that the message content has been opened (e.g., the user has opened a photo, video, document, location or venue, or has listened to an audio file or voice note message). An updateMessageContentOpened update will be generated if something has changed 
class OpenMessageContent extends TdFunction {
  String get tdType => 'openMessageContent';
  String get tdReturnType => 'Ok';


  /// Chat identifier of the message 
  int53? chat_id;

  /// Identifier of the message with the opened content
  int53? message_id;

  OpenMessageContent({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_id,
  });

  OpenMessageContent.fromMap(Map<String, dynamic> map) {
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
