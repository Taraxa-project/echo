import 'package:td_json_client/api/base.dart';


/// Returns detailed statistics about a chat. Currently, this method can be used only for supergroups and channels. Can be used only if supergroupFullInfo.can_get_statistics == true 
class GetChatStatistics extends TdFunction {
  String get tdType => 'getChatStatistics';
  String get tdReturnType => 'ChatStatistics';


  /// Chat identifier 
  int53? chat_id;

  /// Pass true if a dark theme is used by the application
  Bool? is_dark;

  GetChatStatistics({
    super.extra,
    super.client_id,
    this.chat_id,
    this.is_dark,
  });

  GetChatStatistics.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    is_dark = map['is_dark'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'is_dark': is_dark?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
