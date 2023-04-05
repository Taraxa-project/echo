import 'package:td_json_client/src/td_api/td.dart';

/// Describes a feature available to Premium users
abstract class PremiumFeature extends TdObject {
  PremiumFeature({super.extra, super.client_id});
}

/// Increased limits
class PremiumFeatureIncreasedLimits extends PremiumFeature {
  String get tdType => 'premiumFeatureIncreasedLimits';

  PremiumFeatureIncreasedLimits({
    super.extra,
    super.client_id,
  });

  PremiumFeatureIncreasedLimits.fromMap(Map<String, dynamic> map) {
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

/// Increased maximum upload file size
class PremiumFeatureIncreasedUploadFileSize extends PremiumFeature {
  String get tdType => 'premiumFeatureIncreasedUploadFileSize';

  PremiumFeatureIncreasedUploadFileSize({
    super.extra,
    super.client_id,
  });

  PremiumFeatureIncreasedUploadFileSize.fromMap(Map<String, dynamic> map) {
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

/// Improved download speed
class PremiumFeatureImprovedDownloadSpeed extends PremiumFeature {
  String get tdType => 'premiumFeatureImprovedDownloadSpeed';

  PremiumFeatureImprovedDownloadSpeed({
    super.extra,
    super.client_id,
  });

  PremiumFeatureImprovedDownloadSpeed.fromMap(Map<String, dynamic> map) {
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

/// The ability to convert voice notes to text
class PremiumFeatureVoiceRecognition extends PremiumFeature {
  String get tdType => 'premiumFeatureVoiceRecognition';

  PremiumFeatureVoiceRecognition({
    super.extra,
    super.client_id,
  });

  PremiumFeatureVoiceRecognition.fromMap(Map<String, dynamic> map) {
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

/// Disabled ads
class PremiumFeatureDisabledAds extends PremiumFeature {
  String get tdType => 'premiumFeatureDisabledAds';

  PremiumFeatureDisabledAds({
    super.extra,
    super.client_id,
  });

  PremiumFeatureDisabledAds.fromMap(Map<String, dynamic> map) {
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

/// Allowed to use more reactions
class PremiumFeatureUniqueReactions extends PremiumFeature {
  String get tdType => 'premiumFeatureUniqueReactions';

  PremiumFeatureUniqueReactions({
    super.extra,
    super.client_id,
  });

  PremiumFeatureUniqueReactions.fromMap(Map<String, dynamic> map) {
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

/// Allowed to use premium stickers with unique effects
class PremiumFeatureUniqueStickers extends PremiumFeature {
  String get tdType => 'premiumFeatureUniqueStickers';

  PremiumFeatureUniqueStickers({
    super.extra,
    super.client_id,
  });

  PremiumFeatureUniqueStickers.fromMap(Map<String, dynamic> map) {
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

/// Allowed to use custom emoji stickers in message texts and captions
class PremiumFeatureCustomEmoji extends PremiumFeature {
  String get tdType => 'premiumFeatureCustomEmoji';

  PremiumFeatureCustomEmoji({
    super.extra,
    super.client_id,
  });

  PremiumFeatureCustomEmoji.fromMap(Map<String, dynamic> map) {
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

/// Ability to change position of the main chat list, archive and mute all new chats from non-contacts, and completely disable notifications about the user's contacts joined Telegram
class PremiumFeatureAdvancedChatManagement extends PremiumFeature {
  String get tdType => 'premiumFeatureAdvancedChatManagement';

  PremiumFeatureAdvancedChatManagement({
    super.extra,
    super.client_id,
  });

  PremiumFeatureAdvancedChatManagement.fromMap(Map<String, dynamic> map) {
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

/// A badge in the user's profile
class PremiumFeatureProfileBadge extends PremiumFeature {
  String get tdType => 'premiumFeatureProfileBadge';

  PremiumFeatureProfileBadge({
    super.extra,
    super.client_id,
  });

  PremiumFeatureProfileBadge.fromMap(Map<String, dynamic> map) {
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

/// A emoji status shown along with the user's name
class PremiumFeatureEmojiStatus extends PremiumFeature {
  String get tdType => 'premiumFeatureEmojiStatus';

  PremiumFeatureEmojiStatus({
    super.extra,
    super.client_id,
  });

  PremiumFeatureEmojiStatus.fromMap(Map<String, dynamic> map) {
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

/// Profile photo animation on message and chat screens
class PremiumFeatureAnimatedProfilePhoto extends PremiumFeature {
  String get tdType => 'premiumFeatureAnimatedProfilePhoto';

  PremiumFeatureAnimatedProfilePhoto({
    super.extra,
    super.client_id,
  });

  PremiumFeatureAnimatedProfilePhoto.fromMap(Map<String, dynamic> map) {
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

/// The ability to set a custom emoji as a forum topic icon
class PremiumFeatureForumTopicIcon extends PremiumFeature {
  String get tdType => 'premiumFeatureForumTopicIcon';

  PremiumFeatureForumTopicIcon({
    super.extra,
    super.client_id,
  });

  PremiumFeatureForumTopicIcon.fromMap(Map<String, dynamic> map) {
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

/// Allowed to set a premium appllication icons
class PremiumFeatureAppIcons extends PremiumFeature {
  String get tdType => 'premiumFeatureAppIcons';

  PremiumFeatureAppIcons({
    super.extra,
    super.client_id,
  });

  PremiumFeatureAppIcons.fromMap(Map<String, dynamic> map) {
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
