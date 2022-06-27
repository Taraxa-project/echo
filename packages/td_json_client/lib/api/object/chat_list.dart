import 'package:td_json_client/api/base.dart';

abstract class ChatList extends TdObject {}

class ChatListMain extends ChatList {
  String get tdType => 'chatListMain';

  string? extra;
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
class ChatListArchive extends ChatList {
  String get tdType => 'chatListArchive';

  string? extra;
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
class ChatListFilter extends ChatList {
  String get tdType => 'chatListFilter';

  string? extra;
  int? client_id;
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
