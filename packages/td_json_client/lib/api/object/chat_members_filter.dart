import 'package:td_json_client/api/base.dart';

abstract class ChatMembersFilter extends TdObject {}

class ChatMembersFilterContacts extends ChatMembersFilter {
  String get tdType => 'chatMembersFilterContacts';

  string? extra;
  int? client_id;

  ChatMembersFilterContacts({
    this.extra,
    this.client_id,
  });

  ChatMembersFilterContacts.fromMap(Map<String, dynamic> map) {
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
class ChatMembersFilterAdministrators extends ChatMembersFilter {
  String get tdType => 'chatMembersFilterAdministrators';

  string? extra;
  int? client_id;

  ChatMembersFilterAdministrators({
    this.extra,
    this.client_id,
  });

  ChatMembersFilterAdministrators.fromMap(Map<String, dynamic> map) {
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
class ChatMembersFilterMembers extends ChatMembersFilter {
  String get tdType => 'chatMembersFilterMembers';

  string? extra;
  int? client_id;

  ChatMembersFilterMembers({
    this.extra,
    this.client_id,
  });

  ChatMembersFilterMembers.fromMap(Map<String, dynamic> map) {
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
class ChatMembersFilterMention extends ChatMembersFilter {
  String get tdType => 'chatMembersFilterMention';

  string? extra;
  int? client_id;
  int53? message_thread_id;

  ChatMembersFilterMention({
    this.extra,
    this.client_id,
    this.message_thread_id,
  });

  ChatMembersFilterMention.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    message_thread_id = map['message_thread_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'message_thread_id': message_thread_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class ChatMembersFilterRestricted extends ChatMembersFilter {
  String get tdType => 'chatMembersFilterRestricted';

  string? extra;
  int? client_id;

  ChatMembersFilterRestricted({
    this.extra,
    this.client_id,
  });

  ChatMembersFilterRestricted.fromMap(Map<String, dynamic> map) {
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
class ChatMembersFilterBanned extends ChatMembersFilter {
  String get tdType => 'chatMembersFilterBanned';

  string? extra;
  int? client_id;

  ChatMembersFilterBanned({
    this.extra,
    this.client_id,
  });

  ChatMembersFilterBanned.fromMap(Map<String, dynamic> map) {
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
class ChatMembersFilterBots extends ChatMembersFilter {
  String get tdType => 'chatMembersFilterBots';

  string? extra;
  int? client_id;

  ChatMembersFilterBots({
    this.extra,
    this.client_id,
  });

  ChatMembersFilterBots.fromMap(Map<String, dynamic> map) {
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
