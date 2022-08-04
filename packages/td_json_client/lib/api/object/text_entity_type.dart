import 'package:td_json_client/api/base.dart';

/// Represents a part of the text which must be formatted differently
abstract class TextEntityType extends TdObject {
  TextEntityType({super.extra, super.client_id});
}


/// A mention of a user by their username
class TextEntityTypeMention extends TextEntityType {
  String get tdType => 'textEntityTypeMention';


  TextEntityTypeMention({
    super.extra,
    super.client_id,
  });

  TextEntityTypeMention.fromMap(Map<String, dynamic> map) {
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

/// A hashtag text, beginning with "#"
class TextEntityTypeHashtag extends TextEntityType {
  String get tdType => 'textEntityTypeHashtag';


  TextEntityTypeHashtag({
    super.extra,
    super.client_id,
  });

  TextEntityTypeHashtag.fromMap(Map<String, dynamic> map) {
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

/// A cashtag text, beginning with "$" and consisting of capital English letters (e.g., "$USD")
class TextEntityTypeCashtag extends TextEntityType {
  String get tdType => 'textEntityTypeCashtag';


  TextEntityTypeCashtag({
    super.extra,
    super.client_id,
  });

  TextEntityTypeCashtag.fromMap(Map<String, dynamic> map) {
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

/// A bot command, beginning with "/"
class TextEntityTypeBotCommand extends TextEntityType {
  String get tdType => 'textEntityTypeBotCommand';


  TextEntityTypeBotCommand({
    super.extra,
    super.client_id,
  });

  TextEntityTypeBotCommand.fromMap(Map<String, dynamic> map) {
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

/// An HTTP URL
class TextEntityTypeUrl extends TextEntityType {
  String get tdType => 'textEntityTypeUrl';


  TextEntityTypeUrl({
    super.extra,
    super.client_id,
  });

  TextEntityTypeUrl.fromMap(Map<String, dynamic> map) {
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

/// An email address
class TextEntityTypeEmailAddress extends TextEntityType {
  String get tdType => 'textEntityTypeEmailAddress';


  TextEntityTypeEmailAddress({
    super.extra,
    super.client_id,
  });

  TextEntityTypeEmailAddress.fromMap(Map<String, dynamic> map) {
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

/// A phone number
class TextEntityTypePhoneNumber extends TextEntityType {
  String get tdType => 'textEntityTypePhoneNumber';


  TextEntityTypePhoneNumber({
    super.extra,
    super.client_id,
  });

  TextEntityTypePhoneNumber.fromMap(Map<String, dynamic> map) {
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

/// A bank card number. The getBankCardInfo method can be used to get information about the bank card
class TextEntityTypeBankCardNumber extends TextEntityType {
  String get tdType => 'textEntityTypeBankCardNumber';


  TextEntityTypeBankCardNumber({
    super.extra,
    super.client_id,
  });

  TextEntityTypeBankCardNumber.fromMap(Map<String, dynamic> map) {
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

/// A bold text
class TextEntityTypeBold extends TextEntityType {
  String get tdType => 'textEntityTypeBold';


  TextEntityTypeBold({
    super.extra,
    super.client_id,
  });

  TextEntityTypeBold.fromMap(Map<String, dynamic> map) {
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

/// An italic text
class TextEntityTypeItalic extends TextEntityType {
  String get tdType => 'textEntityTypeItalic';


  TextEntityTypeItalic({
    super.extra,
    super.client_id,
  });

  TextEntityTypeItalic.fromMap(Map<String, dynamic> map) {
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

/// An underlined text
class TextEntityTypeUnderline extends TextEntityType {
  String get tdType => 'textEntityTypeUnderline';


  TextEntityTypeUnderline({
    super.extra,
    super.client_id,
  });

  TextEntityTypeUnderline.fromMap(Map<String, dynamic> map) {
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

/// A strikethrough text
class TextEntityTypeStrikethrough extends TextEntityType {
  String get tdType => 'textEntityTypeStrikethrough';


  TextEntityTypeStrikethrough({
    super.extra,
    super.client_id,
  });

  TextEntityTypeStrikethrough.fromMap(Map<String, dynamic> map) {
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

/// A spoiler text. Not supported in secret chats
class TextEntityTypeSpoiler extends TextEntityType {
  String get tdType => 'textEntityTypeSpoiler';


  TextEntityTypeSpoiler({
    super.extra,
    super.client_id,
  });

  TextEntityTypeSpoiler.fromMap(Map<String, dynamic> map) {
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

/// Text that must be formatted as if inside a code HTML tag
class TextEntityTypeCode extends TextEntityType {
  String get tdType => 'textEntityTypeCode';


  TextEntityTypeCode({
    super.extra,
    super.client_id,
  });

  TextEntityTypeCode.fromMap(Map<String, dynamic> map) {
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

/// Text that must be formatted as if inside a pre HTML tag
class TextEntityTypePre extends TextEntityType {
  String get tdType => 'textEntityTypePre';


  TextEntityTypePre({
    super.extra,
    super.client_id,
  });

  TextEntityTypePre.fromMap(Map<String, dynamic> map) {
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

/// Text that must be formatted as if inside pre, and code HTML tags 
class TextEntityTypePreCode extends TextEntityType {
  String get tdType => 'textEntityTypePreCode';


  /// Programming language of the code; as defined by the sender
  string? language;

  TextEntityTypePreCode({
    super.extra,
    super.client_id,
    this.language,
  });

  TextEntityTypePreCode.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    language = map['language'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'language': language?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A text description shown instead of a raw URL 
class TextEntityTypeTextUrl extends TextEntityType {
  String get tdType => 'textEntityTypeTextUrl';


  /// HTTP or tg:// URL to be opened when the link is clicked
  string? url;

  TextEntityTypeTextUrl({
    super.extra,
    super.client_id,
    this.url,
  });

  TextEntityTypeTextUrl.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    url = map['url'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A text shows instead of a raw mention of the user (e.g., when the user has no username) 
class TextEntityTypeMentionName extends TextEntityType {
  String get tdType => 'textEntityTypeMentionName';


  /// Identifier of the mentioned user
  int53? user_id;

  TextEntityTypeMentionName({
    super.extra,
    super.client_id,
    this.user_id,
  });

  TextEntityTypeMentionName.fromMap(Map<String, dynamic> map) {
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

/// A media timestamp 
class TextEntityTypeMediaTimestamp extends TextEntityType {
  String get tdType => 'textEntityTypeMediaTimestamp';


  /// Timestamp from which a video/audio/video note/voice note playing must start, in seconds. The media can be in the content or the web page preview of the current message, or in the same places in the replied message
  int32? media_timestamp;

  TextEntityTypeMediaTimestamp({
    super.extra,
    super.client_id,
    this.media_timestamp,
  });

  TextEntityTypeMediaTimestamp.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    media_timestamp = map['media_timestamp'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'media_timestamp': media_timestamp?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
