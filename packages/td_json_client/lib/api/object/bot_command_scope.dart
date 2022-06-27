import 'package:td_json_client/api/base.dart';

abstract class BotCommandScope extends TdObject {}

class BotCommandScopeDefault extends BotCommandScope {
  String get tdType => 'botCommandScopeDefault';

  string? extra;
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
class BotCommandScopeAllPrivateChats extends BotCommandScope {
  String get tdType => 'botCommandScopeAllPrivateChats';

  string? extra;
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
class BotCommandScopeAllGroupChats extends BotCommandScope {
  String get tdType => 'botCommandScopeAllGroupChats';

  string? extra;
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
class BotCommandScopeAllChatAdministrators extends BotCommandScope {
  String get tdType => 'botCommandScopeAllChatAdministrators';

  string? extra;
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
class BotCommandScopeChat extends BotCommandScope {
  String get tdType => 'botCommandScopeChat';

  string? extra;
  int? client_id;
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
class BotCommandScopeChatAdministrators extends BotCommandScope {
  String get tdType => 'botCommandScopeChatAdministrators';

  string? extra;
  int? client_id;
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
class BotCommandScopeChatMember extends BotCommandScope {
  String get tdType => 'botCommandScopeChatMember';

  string? extra;
  int? client_id;
  int53? chat_id;
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
