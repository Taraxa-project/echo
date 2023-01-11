import 'package:td_json_client/api/base.dart';


/// Adds multiple new members to a chat. Currently, this method is only available for supergroups and channels. This method can't be used to join a chat. Members can't be added to a channel if it has more than 200 members
class AddChatMembers extends TdFunction {
  String get tdType => 'addChatMembers';
  String get tdReturnType => 'Ok';


  /// Chat identifier
  int53? chat_id;

  /// Identifiers of the users to be added to the chat. The maximum number of added users is 20 for supergroups and 100 for channels
  vector<int53>? user_ids;

  AddChatMembers({
    super.extra,
    super.client_id,
    this.chat_id,
    this.user_ids,
  });

  AddChatMembers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['user_ids'] != null) {
      user_ids = [];
      for (var someValue in map['user_ids']) {
        user_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'user_ids': user_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
