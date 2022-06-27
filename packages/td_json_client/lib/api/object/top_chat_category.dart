import 'package:td_json_client/api/base.dart';

abstract class TopChatCategory extends TdObject {}

class TopChatCategoryUsers extends TopChatCategory {
  String get tdType => 'topChatCategoryUsers';

  String? extra;
  int? client_id;

  TopChatCategoryUsers({
    this.extra,
    this.client_id,
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
class TopChatCategoryBots extends TopChatCategory {
  String get tdType => 'topChatCategoryBots';

  String? extra;
  int? client_id;

  TopChatCategoryBots({
    this.extra,
    this.client_id,
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
class TopChatCategoryGroups extends TopChatCategory {
  String get tdType => 'topChatCategoryGroups';

  String? extra;
  int? client_id;

  TopChatCategoryGroups({
    this.extra,
    this.client_id,
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
class TopChatCategoryChannels extends TopChatCategory {
  String get tdType => 'topChatCategoryChannels';

  String? extra;
  int? client_id;

  TopChatCategoryChannels({
    this.extra,
    this.client_id,
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
class TopChatCategoryInlineBots extends TopChatCategory {
  String get tdType => 'topChatCategoryInlineBots';

  String? extra;
  int? client_id;

  TopChatCategoryInlineBots({
    this.extra,
    this.client_id,
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
class TopChatCategoryCalls extends TopChatCategory {
  String get tdType => 'topChatCategoryCalls';

  String? extra;
  int? client_id;

  TopChatCategoryCalls({
    this.extra,
    this.client_id,
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
class TopChatCategoryForwardChats extends TopChatCategory {
  String get tdType => 'topChatCategoryForwardChats';

  String? extra;
  int? client_id;

  TopChatCategoryForwardChats({
    this.extra,
    this.client_id,
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
