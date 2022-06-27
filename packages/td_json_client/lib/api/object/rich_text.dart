import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/document.dart';

abstract class RichText extends TdObject {}

class RichTextPlain extends RichText {
  String get tdType => 'richTextPlain';

  String? extra;
  int? client_id;
  string? text;

  RichTextPlain({
    this.extra,
    this.client_id,
    this.text,
  });

  RichTextPlain.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class RichTextBold extends RichText {
  String get tdType => 'richTextBold';

  String? extra;
  int? client_id;
  RichText? text;

  RichTextBold({
    this.extra,
    this.client_id,
    this.text,
  });

  RichTextBold.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class RichTextItalic extends RichText {
  String get tdType => 'richTextItalic';

  String? extra;
  int? client_id;
  RichText? text;

  RichTextItalic({
    this.extra,
    this.client_id,
    this.text,
  });

  RichTextItalic.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class RichTextUnderline extends RichText {
  String get tdType => 'richTextUnderline';

  String? extra;
  int? client_id;
  RichText? text;

  RichTextUnderline({
    this.extra,
    this.client_id,
    this.text,
  });

  RichTextUnderline.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class RichTextStrikethrough extends RichText {
  String get tdType => 'richTextStrikethrough';

  String? extra;
  int? client_id;
  RichText? text;

  RichTextStrikethrough({
    this.extra,
    this.client_id,
    this.text,
  });

  RichTextStrikethrough.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class RichTextFixed extends RichText {
  String get tdType => 'richTextFixed';

  String? extra;
  int? client_id;
  RichText? text;

  RichTextFixed({
    this.extra,
    this.client_id,
    this.text,
  });

  RichTextFixed.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class RichTextUrl extends RichText {
  String get tdType => 'richTextUrl';

  String? extra;
  int? client_id;
  RichText? text;
  string? url;
  Bool? is_cached;

  RichTextUrl({
    this.extra,
    this.client_id,
    this.text,
    this.url,
    this.is_cached,
  });

  RichTextUrl.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
    url = map['url'];
    is_cached = map['is_cached'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
      'is_cached': is_cached?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class RichTextEmailAddress extends RichText {
  String get tdType => 'richTextEmailAddress';

  String? extra;
  int? client_id;
  RichText? text;
  string? email_address;

  RichTextEmailAddress({
    this.extra,
    this.client_id,
    this.text,
    this.email_address,
  });

  RichTextEmailAddress.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
    email_address = map['email_address'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
      'email_address': email_address?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class RichTextSubscript extends RichText {
  String get tdType => 'richTextSubscript';

  String? extra;
  int? client_id;
  RichText? text;

  RichTextSubscript({
    this.extra,
    this.client_id,
    this.text,
  });

  RichTextSubscript.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class RichTextSuperscript extends RichText {
  String get tdType => 'richTextSuperscript';

  String? extra;
  int? client_id;
  RichText? text;

  RichTextSuperscript({
    this.extra,
    this.client_id,
    this.text,
  });

  RichTextSuperscript.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class RichTextMarked extends RichText {
  String get tdType => 'richTextMarked';

  String? extra;
  int? client_id;
  RichText? text;

  RichTextMarked({
    this.extra,
    this.client_id,
    this.text,
  });

  RichTextMarked.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class RichTextPhoneNumber extends RichText {
  String get tdType => 'richTextPhoneNumber';

  String? extra;
  int? client_id;
  RichText? text;
  string? phone_number;

  RichTextPhoneNumber({
    this.extra,
    this.client_id,
    this.text,
    this.phone_number,
  });

  RichTextPhoneNumber.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
    phone_number = map['phone_number'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
      'phone_number': phone_number?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class RichTextIcon extends RichText {
  String get tdType => 'richTextIcon';

  String? extra;
  int? client_id;
  Document? document;
  int32? width;
  int32? height;

  RichTextIcon({
    this.extra,
    this.client_id,
    this.document,
    this.width,
    this.height,
  });

  RichTextIcon.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    document = TdApiMap.fromMap(map['document']) as Document;
    width = map['width'];
    height = map['height'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'document': document?.toMap(skipNulls: skipNulls),
      'width': width?.toMap(skipNulls: skipNulls),
      'height': height?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class RichTextReference extends RichText {
  String get tdType => 'richTextReference';

  String? extra;
  int? client_id;
  RichText? text;
  string? anchor_name;
  string? url;

  RichTextReference({
    this.extra,
    this.client_id,
    this.text,
    this.anchor_name,
    this.url,
  });

  RichTextReference.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
    anchor_name = map['anchor_name'];
    url = map['url'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
      'anchor_name': anchor_name?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class RichTextAnchor extends RichText {
  String get tdType => 'richTextAnchor';

  String? extra;
  int? client_id;
  string? name;

  RichTextAnchor({
    this.extra,
    this.client_id,
    this.name,
  });

  RichTextAnchor.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    name = map['name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class RichTextAnchorLink extends RichText {
  String get tdType => 'richTextAnchorLink';

  String? extra;
  int? client_id;
  RichText? text;
  string? anchor_name;
  string? url;

  RichTextAnchorLink({
    this.extra,
    this.client_id,
    this.text,
    this.anchor_name,
    this.url,
  });

  RichTextAnchorLink.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
    anchor_name = map['anchor_name'];
    url = map['url'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
      'anchor_name': anchor_name?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class RichTexts extends RichText {
  String get tdType => 'richTexts';

  String? extra;
  int? client_id;
  vector<RichText>? texts;

  RichTexts({
    this.extra,
    this.client_id,
    this.texts,
  });

  RichTexts.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['texts']) {
      texts = [];
      for (var someValue in map['texts']) {
        texts?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'texts': texts?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
