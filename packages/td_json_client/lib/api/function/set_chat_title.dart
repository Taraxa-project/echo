import 'package:td_json_client/api/base.dart';


/// Changes the chat title. Supported only for basic groups, supergroups and channels. Requires can_change_info administrator right
class SetChatTitle extends TdFunction {
  String get tdType => 'setChatTitle';
  String get tdReturnType => 'Ok';


  /// Chat identifier 
  int53? chat_id;

  /// New title of the chat; 1-128 characters
  string? title;

  SetChatTitle({
    super.extra,
    super.client_id,
    this.chat_id,
    this.title,
  });

  SetChatTitle.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    title = map['title'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
