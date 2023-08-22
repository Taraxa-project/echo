import 'package:td_json_client/src/td_api/td.dart';

/// Returns information about a chat folder by its identifier
class GetChatFolder extends TdFunction {
  String get tdType => 'getChatFolder';
  String get tdReturnType => 'ChatFolder';

  /// Chat folder identifier
  int32? chat_folder_id;

  GetChatFolder({
    super.extra,
    super.client_id,
    this.chat_folder_id,
  });

  GetChatFolder.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_folder_id = map['chat_folder_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_folder_id': chat_folder_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
