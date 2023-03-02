import 'package:td_json_client/api/base.dart';

/// Represents the categories of chats for which a list of frequently used chats can be retrieved
abstract class TopChatCategory extends TdObject {
  TopChatCategory({super.extra, super.client_id});
}


/// A category containing frequently used private chats with non-bot users
class TopChatCategoryUsers extends TopChatCategory {
  String get tdType => 'topChatCategoryUsers';


  TopChatCategoryUsers({
    super.extra,
    super.client_id,
  });

  TopChatCategoryUsers.fromMap(Map<String, dynamic> map) {
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

/// A category containing frequently used private chats with bot users
class TopChatCategoryBots extends TopChatCategory {
  String get tdType => 'topChatCategoryBots';


  TopChatCategoryBots({
    super.extra,
    super.client_id,
  });

  TopChatCategoryBots.fromMap(Map<String, dynamic> map) {
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

/// A category containing frequently used basic groups and supergroups
class TopChatCategoryGroups extends TopChatCategory {
  String get tdType => 'topChatCategoryGroups';


  TopChatCategoryGroups({
    super.extra,
    super.client_id,
  });

  TopChatCategoryGroups.fromMap(Map<String, dynamic> map) {
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

/// A category containing frequently used channels
class TopChatCategoryChannels extends TopChatCategory {
  String get tdType => 'topChatCategoryChannels';


  TopChatCategoryChannels({
    super.extra,
    super.client_id,
  });

  TopChatCategoryChannels.fromMap(Map<String, dynamic> map) {
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

/// A category containing frequently used chats with inline bots sorted by their usage in inline mode
class TopChatCategoryInlineBots extends TopChatCategory {
  String get tdType => 'topChatCategoryInlineBots';


  TopChatCategoryInlineBots({
    super.extra,
    super.client_id,
  });

  TopChatCategoryInlineBots.fromMap(Map<String, dynamic> map) {
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

/// A category containing frequently used chats used for calls
class TopChatCategoryCalls extends TopChatCategory {
  String get tdType => 'topChatCategoryCalls';


  TopChatCategoryCalls({
    super.extra,
    super.client_id,
  });

  TopChatCategoryCalls.fromMap(Map<String, dynamic> map) {
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

/// A category containing frequently used chats used to forward messages
class TopChatCategoryForwardChats extends TopChatCategory {
  String get tdType => 'topChatCategoryForwardChats';


  TopChatCategoryForwardChats({
    super.extra,
    super.client_id,
  });

  TopChatCategoryForwardChats.fromMap(Map<String, dynamic> map) {
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
