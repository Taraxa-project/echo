import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/document.dart';

/// Describes a text object inside an instant-view web page
abstract class RichText extends TdObject {
  RichText({super.extra, super.client_id});
}


/// A plain text 
class RichTextPlain extends RichText {
  String get tdType => 'richTextPlain';


  /// Text
  string? text;

  RichTextPlain({
    super.extra,
    super.client_id,
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

/// A bold rich text 
class RichTextBold extends RichText {
  String get tdType => 'richTextBold';


  /// Text
  RichText? text;

  RichTextBold({
    super.extra,
    super.client_id,
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

/// An italicized rich text 
class RichTextItalic extends RichText {
  String get tdType => 'richTextItalic';


  /// Text
  RichText? text;

  RichTextItalic({
    super.extra,
    super.client_id,
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

/// An underlined rich text 
class RichTextUnderline extends RichText {
  String get tdType => 'richTextUnderline';


  /// Text
  RichText? text;

  RichTextUnderline({
    super.extra,
    super.client_id,
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

/// A strikethrough rich text 
class RichTextStrikethrough extends RichText {
  String get tdType => 'richTextStrikethrough';


  /// Text
  RichText? text;

  RichTextStrikethrough({
    super.extra,
    super.client_id,
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

/// A fixed-width rich text 
class RichTextFixed extends RichText {
  String get tdType => 'richTextFixed';


  /// Text
  RichText? text;

  RichTextFixed({
    super.extra,
    super.client_id,
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

/// A rich text URL link 
class RichTextUrl extends RichText {
  String get tdType => 'richTextUrl';


  /// Text 
  RichText? text;

  /// URL 
  string? url;

  /// True, if the URL has cached instant view server-side
  Bool? is_cached;

  RichTextUrl({
    super.extra,
    super.client_id,
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

/// A rich text email link 
class RichTextEmailAddress extends RichText {
  String get tdType => 'richTextEmailAddress';


  /// Text 
  RichText? text;

  /// Email address
  string? email_address;

  RichTextEmailAddress({
    super.extra,
    super.client_id,
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

/// A subscript rich text 
class RichTextSubscript extends RichText {
  String get tdType => 'richTextSubscript';


  /// Text
  RichText? text;

  RichTextSubscript({
    super.extra,
    super.client_id,
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

/// A superscript rich text 
class RichTextSuperscript extends RichText {
  String get tdType => 'richTextSuperscript';


  /// Text
  RichText? text;

  RichTextSuperscript({
    super.extra,
    super.client_id,
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

/// A marked rich text 
class RichTextMarked extends RichText {
  String get tdType => 'richTextMarked';


  /// Text
  RichText? text;

  RichTextMarked({
    super.extra,
    super.client_id,
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

/// A rich text phone number 
class RichTextPhoneNumber extends RichText {
  String get tdType => 'richTextPhoneNumber';


  /// Text 
  RichText? text;

  /// Phone number
  string? phone_number;

  RichTextPhoneNumber({
    super.extra,
    super.client_id,
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

/// A small image inside the text
class RichTextIcon extends RichText {
  String get tdType => 'richTextIcon';


  /// The image represented as a document. The image can be in GIF, JPEG or PNG format
  Document? document;

  /// Width of a bounding box in which the image must be shown; 0 if unknown
  int32? width;

  /// Height of a bounding box in which the image must be shown; 0 if unknown
  int32? height;

  RichTextIcon({
    super.extra,
    super.client_id,
    this.document,
    this.width,
    this.height,
  });

  RichTextIcon.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['document'] != null) {
      document = TdApiMap.fromMap(map['document']) as Document;
    }
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

/// A reference to a richTexts object on the same web page 
class RichTextReference extends RichText {
  String get tdType => 'richTextReference';


  /// The text 
  RichText? text;

  /// The name of a richTextAnchor object, which is the first element of the target richTexts object 
  string? anchor_name;

  /// An HTTP URL, opening the reference
  string? url;

  RichTextReference({
    super.extra,
    super.client_id,
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

/// An anchor 
class RichTextAnchor extends RichText {
  String get tdType => 'richTextAnchor';


  /// Anchor name
  string? name;

  RichTextAnchor({
    super.extra,
    super.client_id,
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

/// A link to an anchor on the same web page 
class RichTextAnchorLink extends RichText {
  String get tdType => 'richTextAnchorLink';


  /// The link text 
  RichText? text;

  /// The anchor name. If the name is empty, the link must bring back to top 
  string? anchor_name;

  /// An HTTP URL, opening the anchor
  string? url;

  RichTextAnchorLink({
    super.extra,
    super.client_id,
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

/// A concatenation of rich texts 
class RichTexts extends RichText {
  String get tdType => 'richTexts';


  /// Texts
  vector<RichText>? texts;

  RichTexts({
    super.extra,
    super.client_id,
    this.texts,
  });

  RichTexts.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['texts'] != null) {
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
