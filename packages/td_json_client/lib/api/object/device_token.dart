import 'package:td_json_client/api/base.dart';

abstract class DeviceToken extends TdObject {}

class DeviceTokenFirebaseCloudMessaging extends DeviceToken {
  String get tdType => 'deviceTokenFirebaseCloudMessaging';

  String? extra;
  int? client_id;
  string? token;
  Bool? encrypt;

  DeviceTokenFirebaseCloudMessaging({
    this.extra,
    this.client_id,
    this.token,
    this.encrypt,
  });

  DeviceTokenFirebaseCloudMessaging.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    token = map['token'];
    encrypt = map['encrypt'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'token': token?.toMap(skipNulls: skipNulls),
      'encrypt': encrypt?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class DeviceTokenApplePush extends DeviceToken {
  String get tdType => 'deviceTokenApplePush';

  String? extra;
  int? client_id;
  string? device_token;
  Bool? is_app_sandbox;

  DeviceTokenApplePush({
    this.extra,
    this.client_id,
    this.device_token,
    this.is_app_sandbox,
  });

  DeviceTokenApplePush.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    device_token = map['device_token'];
    is_app_sandbox = map['is_app_sandbox'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'device_token': device_token?.toMap(skipNulls: skipNulls),
      'is_app_sandbox': is_app_sandbox?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class DeviceTokenApplePushVoIP extends DeviceToken {
  String get tdType => 'deviceTokenApplePushVoIP';

  String? extra;
  int? client_id;
  string? device_token;
  Bool? is_app_sandbox;
  Bool? encrypt;

  DeviceTokenApplePushVoIP({
    this.extra,
    this.client_id,
    this.device_token,
    this.is_app_sandbox,
    this.encrypt,
  });

  DeviceTokenApplePushVoIP.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    device_token = map['device_token'];
    is_app_sandbox = map['is_app_sandbox'];
    encrypt = map['encrypt'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'device_token': device_token?.toMap(skipNulls: skipNulls),
      'is_app_sandbox': is_app_sandbox?.toMap(skipNulls: skipNulls),
      'encrypt': encrypt?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class DeviceTokenWindowsPush extends DeviceToken {
  String get tdType => 'deviceTokenWindowsPush';

  String? extra;
  int? client_id;
  string? access_token;

  DeviceTokenWindowsPush({
    this.extra,
    this.client_id,
    this.access_token,
  });

  DeviceTokenWindowsPush.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    access_token = map['access_token'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'access_token': access_token?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class DeviceTokenMicrosoftPush extends DeviceToken {
  String get tdType => 'deviceTokenMicrosoftPush';

  String? extra;
  int? client_id;
  string? channel_uri;

  DeviceTokenMicrosoftPush({
    this.extra,
    this.client_id,
    this.channel_uri,
  });

  DeviceTokenMicrosoftPush.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    channel_uri = map['channel_uri'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'channel_uri': channel_uri?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class DeviceTokenMicrosoftPushVoIP extends DeviceToken {
  String get tdType => 'deviceTokenMicrosoftPushVoIP';

  String? extra;
  int? client_id;
  string? channel_uri;

  DeviceTokenMicrosoftPushVoIP({
    this.extra,
    this.client_id,
    this.channel_uri,
  });

  DeviceTokenMicrosoftPushVoIP.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    channel_uri = map['channel_uri'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'channel_uri': channel_uri?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class DeviceTokenWebPush extends DeviceToken {
  String get tdType => 'deviceTokenWebPush';

  String? extra;
  int? client_id;
  string? endpoint;
  string? p256dh_base64url;
  string? auth_base64url;

  DeviceTokenWebPush({
    this.extra,
    this.client_id,
    this.endpoint,
    this.p256dh_base64url,
    this.auth_base64url,
  });

  DeviceTokenWebPush.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    endpoint = map['endpoint'];
    p256dh_base64url = map['p256dh_base64url'];
    auth_base64url = map['auth_base64url'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'endpoint': endpoint?.toMap(skipNulls: skipNulls),
      'p256dh_base64url': p256dh_base64url?.toMap(skipNulls: skipNulls),
      'auth_base64url': auth_base64url?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class DeviceTokenSimplePush extends DeviceToken {
  String get tdType => 'deviceTokenSimplePush';

  String? extra;
  int? client_id;
  string? endpoint;

  DeviceTokenSimplePush({
    this.extra,
    this.client_id,
    this.endpoint,
  });

  DeviceTokenSimplePush.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    endpoint = map['endpoint'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'endpoint': endpoint?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class DeviceTokenUbuntuPush extends DeviceToken {
  String get tdType => 'deviceTokenUbuntuPush';

  String? extra;
  int? client_id;
  string? token;

  DeviceTokenUbuntuPush({
    this.extra,
    this.client_id,
    this.token,
  });

  DeviceTokenUbuntuPush.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    token = map['token'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'token': token?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class DeviceTokenBlackBerryPush extends DeviceToken {
  String get tdType => 'deviceTokenBlackBerryPush';

  String? extra;
  int? client_id;
  string? token;

  DeviceTokenBlackBerryPush({
    this.extra,
    this.client_id,
    this.token,
  });

  DeviceTokenBlackBerryPush.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    token = map['token'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'token': token?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class DeviceTokenTizenPush extends DeviceToken {
  String get tdType => 'deviceTokenTizenPush';

  String? extra;
  int? client_id;
  string? reg_id;

  DeviceTokenTizenPush({
    this.extra,
    this.client_id,
    this.reg_id,
  });

  DeviceTokenTizenPush.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    reg_id = map['reg_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'reg_id': reg_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
