import 'package:td_json_client/api/base.dart';


/// Creates a new supergroup from an existing basic group and sends a corresponding messageChatUpgradeTo and messageChatUpgradeFrom; requires creator privileges. Deactivates the original basic group 
class UpgradeBasicGroupChatToSupergroupChat extends TdFunction {
  String get tdType => 'upgradeBasicGroupChatToSupergroupChat';
  String get tdReturnType => 'Chat';


  /// Identifier of the chat to upgrade
  int53? chat_id;

  UpgradeBasicGroupChatToSupergroupChat({
    super.extra,
    super.client_id,
    this.chat_id,
  });

  UpgradeBasicGroupChatToSupergroupChat.fromMap(Map<String, dynamic> map) {
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
