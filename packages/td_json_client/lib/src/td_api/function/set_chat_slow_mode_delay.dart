import 'package:td_json_client/src/td_api/td.dart';

/// Changes the slow mode delay of a chat. Available only for supergroups; requires can_restrict_members rights
class SetChatSlowModeDelay extends TdFunction {
  String get tdType => 'setChatSlowModeDelay';
  String get tdReturnType => 'Ok';

  /// Chat identifier
  int53? chat_id;

  /// New slow mode delay for the chat, in seconds; must be one of 0, 10, 30, 60, 300, 900, 3600
  int32? slow_mode_delay;

  SetChatSlowModeDelay({
    super.extra,
    super.client_id,
    this.chat_id,
    this.slow_mode_delay,
  });

  SetChatSlowModeDelay.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    slow_mode_delay = map['slow_mode_delay'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'slow_mode_delay': slow_mode_delay?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
