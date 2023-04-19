import 'package:td_json_client/src/td_api/td.dart';

/// Represents a data needed to subscribe for push notifications through registerDevice method.
/// To use specific push notification service, the correct application platform must be specified and a valid server authentication data must be uploaded at https://my.telegram.org
abstract class DeviceToken extends TdObject {
  DeviceToken({super.extra, super.client_id});
}

/// A token for Firebase Cloud Messaging
class DeviceTokenFirebaseCloudMessaging extends DeviceToken {
  String get tdType => 'deviceTokenFirebaseCloudMessaging';

  /// Device registration token; may be empty to deregister a device
  string? token;

  /// True, if push notifications must be additionally encrypted
  Bool? encrypt;

  DeviceTokenFirebaseCloudMessaging({
    super.extra,
    super.client_id,
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

/// A token for Apple Push Notification service
class DeviceTokenApplePush extends DeviceToken {
  String get tdType => 'deviceTokenApplePush';

  /// Device token; may be empty to deregister a device
  string? device_token;

  /// True, if App Sandbox is enabled
  Bool? is_app_sandbox;

  DeviceTokenApplePush({
    super.extra,
    super.client_id,
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

/// A token for Apple Push Notification service VoIP notifications
class DeviceTokenApplePushVoIP extends DeviceToken {
  String get tdType => 'deviceTokenApplePushVoIP';

  /// Device token; may be empty to deregister a device
  string? device_token;

  /// True, if App Sandbox is enabled
  Bool? is_app_sandbox;

  /// True, if push notifications must be additionally encrypted
  Bool? encrypt;

  DeviceTokenApplePushVoIP({
    super.extra,
    super.client_id,
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

/// A token for Windows Push Notification Services
class DeviceTokenWindowsPush extends DeviceToken {
  String get tdType => 'deviceTokenWindowsPush';

  /// The access token that will be used to send notifications; may be empty to deregister a device
  string? access_token;

  DeviceTokenWindowsPush({
    super.extra,
    super.client_id,
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

/// A token for Microsoft Push Notification Service
class DeviceTokenMicrosoftPush extends DeviceToken {
  String get tdType => 'deviceTokenMicrosoftPush';

  /// Push notification channel URI; may be empty to deregister a device
  string? channel_uri;

  DeviceTokenMicrosoftPush({
    super.extra,
    super.client_id,
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

/// A token for Microsoft Push Notification Service VoIP channel
class DeviceTokenMicrosoftPushVoIP extends DeviceToken {
  String get tdType => 'deviceTokenMicrosoftPushVoIP';

  /// Push notification channel URI; may be empty to deregister a device
  string? channel_uri;

  DeviceTokenMicrosoftPushVoIP({
    super.extra,
    super.client_id,
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

/// A token for web Push API
class DeviceTokenWebPush extends DeviceToken {
  String get tdType => 'deviceTokenWebPush';

  /// Absolute URL exposed by the push service where the application server can send push messages; may be empty to deregister a device
  string? endpoint;

  /// Base64url-encoded P-256 elliptic curve Diffie-Hellman public key
  string? p256dh_base64url;

  /// Base64url-encoded authentication secret
  string? auth_base64url;

  DeviceTokenWebPush({
    super.extra,
    super.client_id,
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

/// A token for Simple Push API for Firefox OS
class DeviceTokenSimplePush extends DeviceToken {
  String get tdType => 'deviceTokenSimplePush';

  /// Absolute URL exposed by the push service where the application server can send push messages; may be empty to deregister a device
  string? endpoint;

  DeviceTokenSimplePush({
    super.extra,
    super.client_id,
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

/// A token for Ubuntu Push Client service
class DeviceTokenUbuntuPush extends DeviceToken {
  String get tdType => 'deviceTokenUbuntuPush';

  /// Token; may be empty to deregister a device
  string? token;

  DeviceTokenUbuntuPush({
    super.extra,
    super.client_id,
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

/// A token for BlackBerry Push Service
class DeviceTokenBlackBerryPush extends DeviceToken {
  String get tdType => 'deviceTokenBlackBerryPush';

  /// Token; may be empty to deregister a device
  string? token;

  DeviceTokenBlackBerryPush({
    super.extra,
    super.client_id,
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

/// A token for Tizen Push Service
class DeviceTokenTizenPush extends DeviceToken {
  String get tdType => 'deviceTokenTizenPush';

  /// Push service registration identifier; may be empty to deregister a device
  string? reg_id;

  DeviceTokenTizenPush({
    super.extra,
    super.client_id,
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
