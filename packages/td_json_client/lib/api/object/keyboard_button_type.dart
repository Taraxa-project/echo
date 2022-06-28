import 'package:td_json_client/api/base.dart';

/// Describes a keyboard button type
abstract class KeyboardButtonType extends TdObject {}


/// A simple button, with text that must be sent when the button is pressed
class KeyboardButtonTypeText extends KeyboardButtonType {
  String get tdType => 'keyboardButtonTypeText';

  String? extra;
  int? client_id;

  KeyboardButtonTypeText({
    this.extra,
    this.client_id,
  });

  KeyboardButtonTypeText.fromMap(Map<String, dynamic> map) {
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

/// A button that sends the user's phone number when pressed; available only in private chats
class KeyboardButtonTypeRequestPhoneNumber extends KeyboardButtonType {
  String get tdType => 'keyboardButtonTypeRequestPhoneNumber';

  String? extra;
  int? client_id;

  KeyboardButtonTypeRequestPhoneNumber({
    this.extra,
    this.client_id,
  });

  KeyboardButtonTypeRequestPhoneNumber.fromMap(Map<String, dynamic> map) {
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

/// A button that sends the user's location when pressed; available only in private chats
class KeyboardButtonTypeRequestLocation extends KeyboardButtonType {
  String get tdType => 'keyboardButtonTypeRequestLocation';

  String? extra;
  int? client_id;

  KeyboardButtonTypeRequestLocation({
    this.extra,
    this.client_id,
  });

  KeyboardButtonTypeRequestLocation.fromMap(Map<String, dynamic> map) {
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

/// A button that allows the user to create and send a poll when pressed; available only in private chats 
class KeyboardButtonTypeRequestPoll extends KeyboardButtonType {
  String get tdType => 'keyboardButtonTypeRequestPoll';

  String? extra;
  int? client_id;

  /// If true, only regular polls must be allowed to create 
  Bool? force_regular;

  /// If true, only polls in quiz mode must be allowed to create
  Bool? force_quiz;

  KeyboardButtonTypeRequestPoll({
    this.extra,
    this.client_id,
    this.force_regular,
    this.force_quiz,
  });

  KeyboardButtonTypeRequestPoll.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    force_regular = map['force_regular'];
    force_quiz = map['force_quiz'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'force_regular': force_regular?.toMap(skipNulls: skipNulls),
      'force_quiz': force_quiz?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A button that opens a web app by calling getWebAppUrl 
class KeyboardButtonTypeWebApp extends KeyboardButtonType {
  String get tdType => 'keyboardButtonTypeWebApp';

  String? extra;
  int? client_id;

  /// An HTTP URL to pass to getWebAppUrl
  string? url;

  KeyboardButtonTypeWebApp({
    this.extra,
    this.client_id,
    this.url,
  });

  KeyboardButtonTypeWebApp.fromMap(Map<String, dynamic> map) {
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
