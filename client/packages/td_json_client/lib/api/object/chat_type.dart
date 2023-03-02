import 'package:td_json_client/api/base.dart';

/// Describes the type of a chat
abstract class ChatType extends TdObject {
  ChatType({super.extra, super.client_id});
}


/// An ordinary chat with a user 
class ChatTypePrivate extends ChatType {
  String get tdType => 'chatTypePrivate';


  /// User identifier
  int53? user_id;

  ChatTypePrivate({
    super.extra,
    super.client_id,
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

/// A basic group (a chat with 0-200 other users) 
class ChatTypeBasicGroup extends ChatType {
  String get tdType => 'chatTypeBasicGroup';


  /// Basic group identifier
  int53? basic_group_id;

  ChatTypeBasicGroup({
    super.extra,
    super.client_id,
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

/// A supergroup or channel (with unlimited members) 
class ChatTypeSupergroup extends ChatType {
  String get tdType => 'chatTypeSupergroup';


  /// Supergroup or channel identifier 
  int53? supergroup_id;

  /// True, if the supergroup is a channel
  Bool? is_channel;

  ChatTypeSupergroup({
    super.extra,
    super.client_id,
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

/// A secret chat with a user 
class ChatTypeSecret extends ChatType {
  String get tdType => 'chatTypeSecret';


  /// Secret chat identifier 
  int32? secret_chat_id;

  /// User identifier of the secret chat peer
  int53? user_id;

  ChatTypeSecret({
    super.extra,
    super.client_id,
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
