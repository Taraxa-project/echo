import 'package:td_json_client/api/base.dart';

abstract class KeyboardButtonType extends TdObject {}

class KeyboardButtonTypeText extends KeyboardButtonType {
  String get tdType => 'keyboardButtonTypeText';

  string? extra;
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
class KeyboardButtonTypeRequestPhoneNumber extends KeyboardButtonType {
  String get tdType => 'keyboardButtonTypeRequestPhoneNumber';

  string? extra;
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
class KeyboardButtonTypeRequestLocation extends KeyboardButtonType {
  String get tdType => 'keyboardButtonTypeRequestLocation';

  string? extra;
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
class KeyboardButtonTypeRequestPoll extends KeyboardButtonType {
  String get tdType => 'keyboardButtonTypeRequestPoll';

  string? extra;
  int? client_id;
  Bool? force_regular;
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
class KeyboardButtonTypeWebApp extends KeyboardButtonType {
  String get tdType => 'keyboardButtonTypeWebApp';

  string? extra;
  int? client_id;
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
