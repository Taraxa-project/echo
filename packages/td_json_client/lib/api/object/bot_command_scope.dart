import 'package:td_json_client/api/base.dart';

/// Represents the scope to which bot commands are relevant
abstract class BotCommandScope extends TdObject {}


/// A scope covering all users
class BotCommandScopeDefault extends BotCommandScope {
  String get tdType => 'botCommandScopeDefault';

  String? extra;
  int? client_id;

  BotCommandScopeDefault({
    this.extra,
    this.client_id,
  });

  BotCommandScopeDefault.fromMap(Map<String, dynamic> map) {
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

/// A scope covering all private chats
class BotCommandScopeAllPrivateChats extends BotCommandScope {
  String get tdType => 'botCommandScopeAllPrivateChats';

  String? extra;
  int? client_id;

  BotCommandScopeAllPrivateChats({
    this.extra,
    this.client_id,
  });

  BotCommandScopeAllPrivateChats.fromMap(Map<String, dynamic> map) {
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

/// A scope covering all group and supergroup chats
class BotCommandScopeAllGroupChats extends BotCommandScope {
  String get tdType => 'botCommandScopeAllGroupChats';

  String? extra;
  int? client_id;

  BotCommandScopeAllGroupChats({
    this.extra,
    this.client_id,
  });

  BotCommandScopeAllGroupChats.fromMap(Map<String, dynamic> map) {
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

/// A scope covering all group and supergroup chat administrators
class BotCommandScopeAllChatAdministrators extends BotCommandScope {
  String get tdType => 'botCommandScopeAllChatAdministrators';

  String? extra;
  int? client_id;

  BotCommandScopeAllChatAdministrators({
    this.extra,
    this.client_id,
  });

  BotCommandScopeAllChatAdministrators.fromMap(Map<String, dynamic> map) {
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

/// A scope covering all members of a chat 
class BotCommandScopeChat extends BotCommandScope {
  String get tdType => 'botCommandScopeChat';

  String? extra;
  int? client_id;

  /// Chat identifier
  int53? chat_id;

  BotCommandScopeChat({
    this.extra,
    this.client_id,
    this.chat_id,
  });

  BotCommandScopeChat.fromMap(Map<String, dynamic> map) {
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

/// A scope covering all administrators of a chat 
class BotCommandScopeChatAdministrators extends BotCommandScope {
  String get tdType => 'botCommandScopeChatAdministrators';

  String? extra;
  int? client_id;

  /// Chat identifier
  int53? chat_id;

  BotCommandScopeChatAdministrators({
    this.extra,
    this.client_id,
    this.chat_id,
  });

  BotCommandScopeChatAdministrators.fromMap(Map<String, dynamic> map) {
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

/// A scope covering a member of a chat 
class BotCommandScopeChatMember extends BotCommandScope {
  String get tdType => 'botCommandScopeChatMember';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// User identifier
  int53? user_id;

  BotCommandScopeChatMember({
    this.extra,
    this.client_id,
    this.chat_id,
    this.user_id,
  });

  BotCommandScopeChatMember.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    user_id = map['user_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
