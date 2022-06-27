import 'package:td_json_client/api/base.dart';

/// Describes the type of an inline keyboard button
abstract class InlineKeyboardButtonType extends TdObject {}


/// A button that opens a specified URL 
class InlineKeyboardButtonTypeUrl extends InlineKeyboardButtonType {
  String get tdType => 'inlineKeyboardButtonTypeUrl';

  String? extra;
  int? client_id;

  /// HTTP or tg:// URL to open
  string? url;

  InlineKeyboardButtonTypeUrl({
    this.extra,
    this.client_id,
    this.url,
  });

  InlineKeyboardButtonTypeUrl.fromMap(Map<String, dynamic> map) {
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

/// A button that opens a specified URL and automatically authorize the current user by calling getLoginUrlInfo 
class InlineKeyboardButtonTypeLoginUrl extends InlineKeyboardButtonType {
  String get tdType => 'inlineKeyboardButtonTypeLoginUrl';

  String? extra;
  int? client_id;

  /// An HTTP URL to pass to getLoginUrlInfo 
  string? url;

  /// Unique button identifier 
  int53? id;

  /// If non-empty, new text of the button in forwarded messages
  string? forward_text;

  InlineKeyboardButtonTypeLoginUrl({
    this.extra,
    this.client_id,
    this.url,
    this.id,
    this.forward_text,
  });

  InlineKeyboardButtonTypeLoginUrl.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    url = map['url'];
    id = map['id'];
    forward_text = map['forward_text'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'forward_text': forward_text?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A button that opens a web app by calling openWebApp 
class InlineKeyboardButtonTypeWebApp extends InlineKeyboardButtonType {
  String get tdType => 'inlineKeyboardButtonTypeWebApp';

  String? extra;
  int? client_id;

  /// An HTTP URL to pass to openWebApp
  string? url;

  InlineKeyboardButtonTypeWebApp({
    this.extra,
    this.client_id,
    this.url,
  });

  InlineKeyboardButtonTypeWebApp.fromMap(Map<String, dynamic> map) {
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

/// A button that sends a callback query to a bot 
class InlineKeyboardButtonTypeCallback extends InlineKeyboardButtonType {
  String get tdType => 'inlineKeyboardButtonTypeCallback';

  String? extra;
  int? client_id;

  /// Data to be sent to the bot via a callback query
  bytes? data;

  InlineKeyboardButtonTypeCallback({
    this.extra,
    this.client_id,
    this.data,
  });

  InlineKeyboardButtonTypeCallback.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    data = map['data'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'data': data?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A button that asks for password of the current user and then sends a callback query to a bot 
class InlineKeyboardButtonTypeCallbackWithPassword extends InlineKeyboardButtonType {
  String get tdType => 'inlineKeyboardButtonTypeCallbackWithPassword';

  String? extra;
  int? client_id;

  /// Data to be sent to the bot via a callback query
  bytes? data;

  InlineKeyboardButtonTypeCallbackWithPassword({
    this.extra,
    this.client_id,
    this.data,
  });

  InlineKeyboardButtonTypeCallbackWithPassword.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    data = map['data'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'data': data?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A button with a game that sends a callback query to a bot. This button must be in the first column and row of the keyboard and can be attached only to a message with content of the type messageGame
class InlineKeyboardButtonTypeCallbackGame extends InlineKeyboardButtonType {
  String get tdType => 'inlineKeyboardButtonTypeCallbackGame';

  String? extra;
  int? client_id;

  InlineKeyboardButtonTypeCallbackGame({
    this.extra,
    this.client_id,
  });

  InlineKeyboardButtonTypeCallbackGame.fromMap(Map<String, dynamic> map) {
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

/// A button that forces an inline query to the bot to be inserted in the input field 
class InlineKeyboardButtonTypeSwitchInline extends InlineKeyboardButtonType {
  String get tdType => 'inlineKeyboardButtonTypeSwitchInline';

  String? extra;
  int? client_id;

  /// Inline query to be sent to the bot 
  string? query;

  /// True, if the inline query must be sent from the current chat
  Bool? in_current_chat;

  InlineKeyboardButtonTypeSwitchInline({
    this.extra,
    this.client_id,
    this.query,
    this.in_current_chat,
  });

  InlineKeyboardButtonTypeSwitchInline.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    query = map['query'];
    in_current_chat = map['in_current_chat'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'query': query?.toMap(skipNulls: skipNulls),
      'in_current_chat': in_current_chat?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A button to buy something. This button must be in the first column and row of the keyboard and can be attached only to a message with content of the type messageInvoice
class InlineKeyboardButtonTypeBuy extends InlineKeyboardButtonType {
  String get tdType => 'inlineKeyboardButtonTypeBuy';

  String? extra;
  int? client_id;

  InlineKeyboardButtonTypeBuy({
    this.extra,
    this.client_id,
  });

  InlineKeyboardButtonTypeBuy.fromMap(Map<String, dynamic> map) {
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

/// A button with a user reference to be handled in the same way as textEntityTypeMentionName entities 
class InlineKeyboardButtonTypeUser extends InlineKeyboardButtonType {
  String get tdType => 'inlineKeyboardButtonTypeUser';

  String? extra;
  int? client_id;

  /// User identifier
  int53? user_id;

  InlineKeyboardButtonTypeUser({
    this.extra,
    this.client_id,
    this.user_id,
  });

  InlineKeyboardButtonTypeUser.fromMap(Map<String, dynamic> map) {
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
