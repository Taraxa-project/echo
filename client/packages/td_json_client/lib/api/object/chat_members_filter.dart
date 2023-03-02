import 'package:td_json_client/api/base.dart';

/// Specifies the kind of chat members to return in searchChatMembers
abstract class ChatMembersFilter extends TdObject {
  ChatMembersFilter({super.extra, super.client_id});
}


/// Returns contacts of the user
class ChatMembersFilterContacts extends ChatMembersFilter {
  String get tdType => 'chatMembersFilterContacts';


  ChatMembersFilterContacts({
    super.extra,
    super.client_id,
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

/// Returns the owner and administrators
class ChatMembersFilterAdministrators extends ChatMembersFilter {
  String get tdType => 'chatMembersFilterAdministrators';


  ChatMembersFilterAdministrators({
    super.extra,
    super.client_id,
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

/// Returns all chat members, including restricted chat members
class ChatMembersFilterMembers extends ChatMembersFilter {
  String get tdType => 'chatMembersFilterMembers';


  ChatMembersFilterMembers({
    super.extra,
    super.client_id,
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

/// Returns users which can be mentioned in the chat 
class ChatMembersFilterMention extends ChatMembersFilter {
  String get tdType => 'chatMembersFilterMention';


  /// If non-zero, the identifier of the current message thread
  int53? message_thread_id;

  ChatMembersFilterMention({
    super.extra,
    super.client_id,
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

/// Returns users under certain restrictions in the chat; can be used only by administrators in a supergroup
class ChatMembersFilterRestricted extends ChatMembersFilter {
  String get tdType => 'chatMembersFilterRestricted';


  ChatMembersFilterRestricted({
    super.extra,
    super.client_id,
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

/// Returns users banned from the chat; can be used only by administrators in a supergroup or in a channel
class ChatMembersFilterBanned extends ChatMembersFilter {
  String get tdType => 'chatMembersFilterBanned';


  ChatMembersFilterBanned({
    super.extra,
    super.client_id,
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

/// Returns bot members of the chat
class ChatMembersFilterBots extends ChatMembersFilter {
  String get tdType => 'chatMembersFilterBots';


  ChatMembersFilterBots({
    super.extra,
    super.client_id,
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
