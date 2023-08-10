import 'package:td_json_client/src/td_api/td.dart';

/// Changes the order of chat folders
class ReorderChatFolders extends TdFunction {
  String get tdType => 'reorderChatFolders';
  String get tdReturnType => 'Ok';

  /// Identifiers of chat folders in the new correct order
  vector<int32>? chat_folder_ids;

  /// Position of the main chat list among chat folders, 0-based. Can be non-zero only for Premium users
  int32? main_chat_list_position;

  ReorderChatFolders({
    super.extra,
    super.client_id,
    this.chat_folder_ids,
    this.main_chat_list_position,
  });

  ReorderChatFolders.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['chat_folder_ids'] != null) {
      chat_folder_ids = [];
      for (var someValue in map['chat_folder_ids']) {
        chat_folder_ids?.add(someValue);
      }
    }
    main_chat_list_position = map['main_chat_list_position'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_folder_ids': chat_folder_ids?.toMap(skipNulls: skipNulls),
      'main_chat_list_position': main_chat_list_position?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
