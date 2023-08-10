import 'package:td_json_client/src/td_api/td.dart';

/// Changes the translatable state of a chat; for Telegram Premium users only
class ToggleChatIsTranslatable extends TdFunction {
  String get tdType => 'toggleChatIsTranslatable';
  String get tdReturnType => 'Ok';

  /// Chat identifier
  int53? chat_id;

  /// New value of is_translatable
  Bool? is_translatable;

  ToggleChatIsTranslatable({
    super.extra,
    super.client_id,
    this.chat_id,
    this.is_translatable,
  });

  ToggleChatIsTranslatable.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    is_translatable = map['is_translatable'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'is_translatable': is_translatable?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
