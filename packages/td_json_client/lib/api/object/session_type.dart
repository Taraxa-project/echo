import 'package:td_json_client/api/base.dart';

/// Represents the type of a session
abstract class SessionType extends TdObject {}


/// The session is running on an Android device
class SessionTypeAndroid extends SessionType {
  String get tdType => 'sessionTypeAndroid';

  String? extra;
  int? client_id;

  SessionTypeAndroid({
    this.extra,
    this.client_id,
  });

  SessionTypeAndroid.fromMap(Map<String, dynamic> map) {
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

/// The session is running on a generic Apple device
class SessionTypeApple extends SessionType {
  String get tdType => 'sessionTypeApple';

  String? extra;
  int? client_id;

  SessionTypeApple({
    this.extra,
    this.client_id,
  });

  SessionTypeApple.fromMap(Map<String, dynamic> map) {
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

/// The session is running on the Brave browser
class SessionTypeBrave extends SessionType {
  String get tdType => 'sessionTypeBrave';

  String? extra;
  int? client_id;

  SessionTypeBrave({
    this.extra,
    this.client_id,
  });

  SessionTypeBrave.fromMap(Map<String, dynamic> map) {
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

/// The session is running on the Chrome browser
class SessionTypeChrome extends SessionType {
  String get tdType => 'sessionTypeChrome';

  String? extra;
  int? client_id;

  SessionTypeChrome({
    this.extra,
    this.client_id,
  });

  SessionTypeChrome.fromMap(Map<String, dynamic> map) {
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

/// The session is running on the Edge browser
class SessionTypeEdge extends SessionType {
  String get tdType => 'sessionTypeEdge';

  String? extra;
  int? client_id;

  SessionTypeEdge({
    this.extra,
    this.client_id,
  });

  SessionTypeEdge.fromMap(Map<String, dynamic> map) {
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

/// The session is running on the Firefox browser
class SessionTypeFirefox extends SessionType {
  String get tdType => 'sessionTypeFirefox';

  String? extra;
  int? client_id;

  SessionTypeFirefox({
    this.extra,
    this.client_id,
  });

  SessionTypeFirefox.fromMap(Map<String, dynamic> map) {
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

/// The session is running on an iPad device
class SessionTypeIpad extends SessionType {
  String get tdType => 'sessionTypeIpad';

  String? extra;
  int? client_id;

  SessionTypeIpad({
    this.extra,
    this.client_id,
  });

  SessionTypeIpad.fromMap(Map<String, dynamic> map) {
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

/// The session is running on an iPhone device
class SessionTypeIphone extends SessionType {
  String get tdType => 'sessionTypeIphone';

  String? extra;
  int? client_id;

  SessionTypeIphone({
    this.extra,
    this.client_id,
  });

  SessionTypeIphone.fromMap(Map<String, dynamic> map) {
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

/// The session is running on a Linux device
class SessionTypeLinux extends SessionType {
  String get tdType => 'sessionTypeLinux';

  String? extra;
  int? client_id;

  SessionTypeLinux({
    this.extra,
    this.client_id,
  });

  SessionTypeLinux.fromMap(Map<String, dynamic> map) {
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

/// The session is running on a Mac device
class SessionTypeMac extends SessionType {
  String get tdType => 'sessionTypeMac';

  String? extra;
  int? client_id;

  SessionTypeMac({
    this.extra,
    this.client_id,
  });

  SessionTypeMac.fromMap(Map<String, dynamic> map) {
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

/// The session is running on the Opera browser
class SessionTypeOpera extends SessionType {
  String get tdType => 'sessionTypeOpera';

  String? extra;
  int? client_id;

  SessionTypeOpera({
    this.extra,
    this.client_id,
  });

  SessionTypeOpera.fromMap(Map<String, dynamic> map) {
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

/// The session is running on the Safari browser
class SessionTypeSafari extends SessionType {
  String get tdType => 'sessionTypeSafari';

  String? extra;
  int? client_id;

  SessionTypeSafari({
    this.extra,
    this.client_id,
  });

  SessionTypeSafari.fromMap(Map<String, dynamic> map) {
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

/// The session is running on an Ubuntu device
class SessionTypeUbuntu extends SessionType {
  String get tdType => 'sessionTypeUbuntu';

  String? extra;
  int? client_id;

  SessionTypeUbuntu({
    this.extra,
    this.client_id,
  });

  SessionTypeUbuntu.fromMap(Map<String, dynamic> map) {
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

/// The session is running on an unknown type of device
class SessionTypeUnknown extends SessionType {
  String get tdType => 'sessionTypeUnknown';

  String? extra;
  int? client_id;

  SessionTypeUnknown({
    this.extra,
    this.client_id,
  });

  SessionTypeUnknown.fromMap(Map<String, dynamic> map) {
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

/// The session is running on the Vivaldi browser
class SessionTypeVivaldi extends SessionType {
  String get tdType => 'sessionTypeVivaldi';

  String? extra;
  int? client_id;

  SessionTypeVivaldi({
    this.extra,
    this.client_id,
  });

  SessionTypeVivaldi.fromMap(Map<String, dynamic> map) {
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

/// The session is running on a Windows device
class SessionTypeWindows extends SessionType {
  String get tdType => 'sessionTypeWindows';

  String? extra;
  int? client_id;

  SessionTypeWindows({
    this.extra,
    this.client_id,
  });

  SessionTypeWindows.fromMap(Map<String, dynamic> map) {
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

/// The session is running on an Xbox console
class SessionTypeXbox extends SessionType {
  String get tdType => 'sessionTypeXbox';

  String? extra;
  int? client_id;

  SessionTypeXbox({
    this.extra,
    this.client_id,
  });

  SessionTypeXbox.fromMap(Map<String, dynamic> map) {
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
