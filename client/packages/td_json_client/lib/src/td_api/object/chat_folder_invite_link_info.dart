import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_folder_info.dart';

/// Contains information about an invite link to a chat folder
class ChatFolderInviteLinkInfo extends TdObject {
  String get tdType => 'chatFolderInviteLinkInfo';

  /// Basic information about the chat folder; chat folder identifier will be 0 if the user didn't have the chat folder yet
  ChatFolderInfo? chat_folder_info;

  /// Identifiers of the chats from the link, which aren't added to the folder yet
  vector<int53>? missing_chat_ids;

  /// Identifiers of the chats from the link, which are added to the folder already
  vector<int53>? added_chat_ids;

  ChatFolderInviteLinkInfo({
    super.extra,
    super.client_id,
    this.chat_folder_info,
    this.missing_chat_ids,
    this.added_chat_ids,
  });

  ChatFolderInviteLinkInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['chat_folder_info'] != null) {
      chat_folder_info = TdApiMap.fromMap(map['chat_folder_info']) as ChatFolderInfo;
    }
    if (map['missing_chat_ids'] != null) {
      missing_chat_ids = [];
      for (var someValue in map['missing_chat_ids']) {
        missing_chat_ids?.add(someValue);
      }
    }
    if (map['added_chat_ids'] != null) {
      added_chat_ids = [];
      for (var someValue in map['added_chat_ids']) {
        added_chat_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_folder_info': chat_folder_info?.toMap(skipNulls: skipNulls),
      'missing_chat_ids': missing_chat_ids?.toMap(skipNulls: skipNulls),
      'added_chat_ids': added_chat_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
