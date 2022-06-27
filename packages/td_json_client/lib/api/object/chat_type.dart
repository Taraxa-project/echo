import 'package:td_json_client/api/base.dart';

abstract class ChatType extends TdObject {}

class ChatTypePrivate extends ChatType {
  String get tdType => 'chatTypePrivate';

  string? extra;
  int? client_id;
  int53? user_id;

  ChatTypePrivate({
    this.extra,
    this.client_id,
    this.user_id,
  });

  ChatTypePrivate.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class ChatTypeBasicGroup extends ChatType {
  String get tdType => 'chatTypeBasicGroup';

  string? extra;
  int? client_id;
  int53? basic_group_id;

  ChatTypeBasicGroup({
    this.extra,
    this.client_id,
    this.basic_group_id,
  });

  ChatTypeBasicGroup.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    basic_group_id = map['basic_group_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'basic_group_id': basic_group_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class ChatTypeSupergroup extends ChatType {
  String get tdType => 'chatTypeSupergroup';

  string? extra;
  int? client_id;
  int53? supergroup_id;
  Bool? is_channel;

  ChatTypeSupergroup({
    this.extra,
    this.client_id,
    this.supergroup_id,
    this.is_channel,
  });

  ChatTypeSupergroup.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    supergroup_id = map['supergroup_id'];
    is_channel = map['is_channel'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'supergroup_id': supergroup_id?.toMap(skipNulls: skipNulls),
      'is_channel': is_channel?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class ChatTypeSecret extends ChatType {
  String get tdType => 'chatTypeSecret';

  string? extra;
  int? client_id;
  int32? secret_chat_id;
  int53? user_id;

  ChatTypeSecret({
    this.extra,
    this.client_id,
    this.secret_chat_id,
    this.user_id,
  });

  ChatTypeSecret.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    secret_chat_id = map['secret_chat_id'];
    user_id = map['user_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'secret_chat_id': secret_chat_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
