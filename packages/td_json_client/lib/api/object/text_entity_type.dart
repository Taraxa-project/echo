import 'package:td_json_client/api/base.dart';

abstract class TextEntityType extends TdObject {}

class TextEntityTypeMention extends TextEntityType {
  String get tdType => 'textEntityTypeMention';

  string? extra;
  int? client_id;

  TextEntityTypeMention({
    this.extra,
    this.client_id,
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
class TextEntityTypeHashtag extends TextEntityType {
  String get tdType => 'textEntityTypeHashtag';

  string? extra;
  int? client_id;

  TextEntityTypeHashtag({
    this.extra,
    this.client_id,
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
class TextEntityTypeCashtag extends TextEntityType {
  String get tdType => 'textEntityTypeCashtag';

  string? extra;
  int? client_id;

  TextEntityTypeCashtag({
    this.extra,
    this.client_id,
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
class TextEntityTypeBotCommand extends TextEntityType {
  String get tdType => 'textEntityTypeBotCommand';

  string? extra;
  int? client_id;

  TextEntityTypeBotCommand({
    this.extra,
    this.client_id,
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
class TextEntityTypeUrl extends TextEntityType {
  String get tdType => 'textEntityTypeUrl';

  string? extra;
  int? client_id;

  TextEntityTypeUrl({
    this.extra,
    this.client_id,
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
class TextEntityTypeEmailAddress extends TextEntityType {
  String get tdType => 'textEntityTypeEmailAddress';

  string? extra;
  int? client_id;

  TextEntityTypeEmailAddress({
    this.extra,
    this.client_id,
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
class TextEntityTypePhoneNumber extends TextEntityType {
  String get tdType => 'textEntityTypePhoneNumber';

  string? extra;
  int? client_id;

  TextEntityTypePhoneNumber({
    this.extra,
    this.client_id,
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
class TextEntityTypeBankCardNumber extends TextEntityType {
  String get tdType => 'textEntityTypeBankCardNumber';

  string? extra;
  int? client_id;

  TextEntityTypeBankCardNumber({
    this.extra,
    this.client_id,
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
class TextEntityTypeBold extends TextEntityType {
  String get tdType => 'textEntityTypeBold';

  string? extra;
  int? client_id;

  TextEntityTypeBold({
    this.extra,
    this.client_id,
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
class TextEntityTypeItalic extends TextEntityType {
  String get tdType => 'textEntityTypeItalic';

  string? extra;
  int? client_id;

  TextEntityTypeItalic({
    this.extra,
    this.client_id,
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
class TextEntityTypeUnderline extends TextEntityType {
  String get tdType => 'textEntityTypeUnderline';

  string? extra;
  int? client_id;

  TextEntityTypeUnderline({
    this.extra,
    this.client_id,
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
class TextEntityTypeStrikethrough extends TextEntityType {
  String get tdType => 'textEntityTypeStrikethrough';

  string? extra;
  int? client_id;

  TextEntityTypeStrikethrough({
    this.extra,
    this.client_id,
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
class TextEntityTypeSpoiler extends TextEntityType {
  String get tdType => 'textEntityTypeSpoiler';

  string? extra;
  int? client_id;

  TextEntityTypeSpoiler({
    this.extra,
    this.client_id,
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
class TextEntityTypeCode extends TextEntityType {
  String get tdType => 'textEntityTypeCode';

  string? extra;
  int? client_id;

  TextEntityTypeCode({
    this.extra,
    this.client_id,
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
class TextEntityTypePre extends TextEntityType {
  String get tdType => 'textEntityTypePre';

  string? extra;
  int? client_id;

  TextEntityTypePre({
    this.extra,
    this.client_id,
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
class TextEntityTypePreCode extends TextEntityType {
  String get tdType => 'textEntityTypePreCode';

  string? extra;
  int? client_id;
  string? language;

  TextEntityTypePreCode({
    this.extra,
    this.client_id,
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
class TextEntityTypeTextUrl extends TextEntityType {
  String get tdType => 'textEntityTypeTextUrl';

  string? extra;
  int? client_id;
  string? url;

  TextEntityTypeTextUrl({
    this.extra,
    this.client_id,
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
class TextEntityTypeMentionName extends TextEntityType {
  String get tdType => 'textEntityTypeMentionName';

  string? extra;
  int? client_id;
  int53? user_id;

  TextEntityTypeMentionName({
    this.extra,
    this.client_id,
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
class TextEntityTypeMediaTimestamp extends TextEntityType {
  String get tdType => 'textEntityTypeMediaTimestamp';

  string? extra;
  int? client_id;
  int32? media_timestamp;

  TextEntityTypeMediaTimestamp({
    this.extra,
    this.client_id,
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
