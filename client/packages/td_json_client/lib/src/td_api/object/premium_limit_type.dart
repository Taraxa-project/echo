import 'package:td_json_client/src/td_api/td.dart';

/// Describes type of a limit, increased for Premium users
abstract class PremiumLimitType extends TdObject {
  PremiumLimitType({super.extra, super.client_id});
}

/// The maximum number of joined supergroups and channels
class PremiumLimitTypeSupergroupCount extends PremiumLimitType {
  String get tdType => 'premiumLimitTypeSupergroupCount';

  PremiumLimitTypeSupergroupCount({
    super.extra,
    super.client_id,
  });

  PremiumLimitTypeSupergroupCount.fromMap(Map<String, dynamic> map) {
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

/// The maximum number of pinned chats in the main chat list
class PremiumLimitTypePinnedChatCount extends PremiumLimitType {
  String get tdType => 'premiumLimitTypePinnedChatCount';

  PremiumLimitTypePinnedChatCount({
    super.extra,
    super.client_id,
  });

  PremiumLimitTypePinnedChatCount.fromMap(Map<String, dynamic> map) {
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

/// The maximum number of created public chats
class PremiumLimitTypeCreatedPublicChatCount extends PremiumLimitType {
  String get tdType => 'premiumLimitTypeCreatedPublicChatCount';

  PremiumLimitTypeCreatedPublicChatCount({
    super.extra,
    super.client_id,
  });

  PremiumLimitTypeCreatedPublicChatCount.fromMap(Map<String, dynamic> map) {
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

/// The maximum number of saved animations
class PremiumLimitTypeSavedAnimationCount extends PremiumLimitType {
  String get tdType => 'premiumLimitTypeSavedAnimationCount';

  PremiumLimitTypeSavedAnimationCount({
    super.extra,
    super.client_id,
  });

  PremiumLimitTypeSavedAnimationCount.fromMap(Map<String, dynamic> map) {
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

/// The maximum number of favorite stickers
class PremiumLimitTypeFavoriteStickerCount extends PremiumLimitType {
  String get tdType => 'premiumLimitTypeFavoriteStickerCount';

  PremiumLimitTypeFavoriteStickerCount({
    super.extra,
    super.client_id,
  });

  PremiumLimitTypeFavoriteStickerCount.fromMap(Map<String, dynamic> map) {
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

/// The maximum number of chat filters
class PremiumLimitTypeChatFilterCount extends PremiumLimitType {
  String get tdType => 'premiumLimitTypeChatFilterCount';

  PremiumLimitTypeChatFilterCount({
    super.extra,
    super.client_id,
  });

  PremiumLimitTypeChatFilterCount.fromMap(Map<String, dynamic> map) {
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

/// The maximum number of pinned and always included, or always excluded chats in a chat filter
class PremiumLimitTypeChatFilterChosenChatCount extends PremiumLimitType {
  String get tdType => 'premiumLimitTypeChatFilterChosenChatCount';

  PremiumLimitTypeChatFilterChosenChatCount({
    super.extra,
    super.client_id,
  });

  PremiumLimitTypeChatFilterChosenChatCount.fromMap(Map<String, dynamic> map) {
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

/// The maximum number of pinned chats in the archive chat list
class PremiumLimitTypePinnedArchivedChatCount extends PremiumLimitType {
  String get tdType => 'premiumLimitTypePinnedArchivedChatCount';

  PremiumLimitTypePinnedArchivedChatCount({
    super.extra,
    super.client_id,
  });

  PremiumLimitTypePinnedArchivedChatCount.fromMap(Map<String, dynamic> map) {
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

/// The maximum length of sent media caption
class PremiumLimitTypeCaptionLength extends PremiumLimitType {
  String get tdType => 'premiumLimitTypeCaptionLength';

  PremiumLimitTypeCaptionLength({
    super.extra,
    super.client_id,
  });

  PremiumLimitTypeCaptionLength.fromMap(Map<String, dynamic> map) {
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

/// The maximum length of the user's bio
class PremiumLimitTypeBioLength extends PremiumLimitType {
  String get tdType => 'premiumLimitTypeBioLength';

  PremiumLimitTypeBioLength({
    super.extra,
    super.client_id,
  });

  PremiumLimitTypeBioLength.fromMap(Map<String, dynamic> map) {
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
