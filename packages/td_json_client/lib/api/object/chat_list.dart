import 'package:td_json_client/api/base.dart';

/// Describes a list of chats
abstract class ChatList extends TdObject {}


/// A main list of chats
class ChatListMain extends ChatList {
  String get tdType => 'chatListMain';

  String? extra;
  int? client_id;

  ChatListMain({
    this.extra,
    this.client_id,
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

  String? extra;
  int? client_id;

  ChatListArchive({
    this.extra,
    this.client_id,
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

/// A list of chats belonging to a chat filter 
class ChatListFilter extends ChatList {
  String get tdType => 'chatListFilter';

  String? extra;
  int? client_id;

  /// Chat filter identifier
  int32? chat_filter_id;

  ChatListFilter({
    this.extra,
    this.client_id,
    this.chat_filter_id,
  });

  ChatListFilter.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_filter_id = map['chat_filter_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_filter_id': chat_filter_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
