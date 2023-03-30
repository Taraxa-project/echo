import 'package:td_json_client/src/td_api/td.dart';

/// Returns detailed statistics about a message. Can be used only if message.can_get_statistics == true
class GetMessageStatistics extends TdFunction {
  String get tdType => 'getMessageStatistics';
  String get tdReturnType => 'MessageStatistics';

  /// Chat identifier
  int53? chat_id;

  /// Message identifier
  int53? message_id;

  /// Pass true if a dark theme is used by the application
  Bool? is_dark;

  GetMessageStatistics({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_id,
    this.is_dark,
  });

  GetMessageStatistics.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    is_dark = map['is_dark'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'is_dark': is_dark?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
