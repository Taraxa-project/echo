import 'package:td_json_client/src/td_api/td.dart';

/// Describes a list of chats
abstract class ChatList extends TdObject {
  ChatList({super.extra, super.client_id});
}

/// A main list of chats
class ChatListMain extends ChatList {
  String get tdType => 'chatListMain';

  ChatListMain({
    super.extra,
    super.client_id,
  });

  ChatListMain.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A list of chats usually located at the top of the main chat list. Unmuted chats are automatically moved from the Archive to the Main chat list when a new message arrives
class ChatListArchive extends ChatList {
  String get tdType => 'chatListArchive';

  ChatListArchive({
    super.extra,
    super.client_id,
  });

  ChatListArchive.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A list of chats added to a chat folder
class ChatListFolder extends ChatList {
  String get tdType => 'chatListFolder';

  /// Chat folder identifier
  int32? chat_folder_id;

  ChatListFolder({
    super.extra,
    super.client_id,
    this.chat_folder_id,
  });

  ChatListFolder.fromMap(Map<String, dynamic> map) {
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
