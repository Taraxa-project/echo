import 'package:td_json_client/api/base.dart';


/// Removes all pinned messages from a chat; requires can_pin_messages rights in the group or can_edit_messages rights in the channel 
class UnpinAllChatMessages extends TdFunction {
  String get tdType => 'unpinAllChatMessages';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Identifier of the chat
  int53? chat_id;

  UnpinAllChatMessages({
    this.extra,
    this.client_id,
    this.chat_id,
  });

  UnpinAllChatMessages.fromMap(Map<String, dynamic> map) {
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
