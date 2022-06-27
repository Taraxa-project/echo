import 'package:td_json_client/api/base.dart';

abstract class InlineKeyboardButtonType extends TdObject {}

class InlineKeyboardButtonTypeUrl extends InlineKeyboardButtonType {
  String get tdType => 'inlineKeyboardButtonTypeUrl';

  string? extra;
  int? client_id;
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
class InlineKeyboardButtonTypeLoginUrl extends InlineKeyboardButtonType {
  String get tdType => 'inlineKeyboardButtonTypeLoginUrl';

  string? extra;
  int? client_id;
  string? url;
  int53? id;
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
class InlineKeyboardButtonTypeCallback extends InlineKeyboardButtonType {
  String get tdType => 'inlineKeyboardButtonTypeCallback';

  string? extra;
  int? client_id;
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
class InlineKeyboardButtonTypeCallbackWithPassword extends InlineKeyboardButtonType {
  String get tdType => 'inlineKeyboardButtonTypeCallbackWithPassword';

  string? extra;
  int? client_id;
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
class InlineKeyboardButtonTypeCallbackGame extends InlineKeyboardButtonType {
  String get tdType => 'inlineKeyboardButtonTypeCallbackGame';

  string? extra;
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
class InlineKeyboardButtonTypeSwitchInline extends InlineKeyboardButtonType {
  String get tdType => 'inlineKeyboardButtonTypeSwitchInline';

  string? extra;
  int? client_id;
  string? query;
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
class InlineKeyboardButtonTypeBuy extends InlineKeyboardButtonType {
  String get tdType => 'inlineKeyboardButtonTypeBuy';

  string? extra;
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
class InlineKeyboardButtonTypeUser extends InlineKeyboardButtonType {
  String get tdType => 'inlineKeyboardButtonTypeUser';

  string? extra;
  int? client_id;
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
