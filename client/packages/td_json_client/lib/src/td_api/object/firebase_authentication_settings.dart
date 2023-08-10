import 'package:td_json_client/src/td_api/td.dart';

/// Contains settings for Firebase Authentication in the official applications
abstract class FirebaseAuthenticationSettings extends TdObject {
  FirebaseAuthenticationSettings({super.extra, super.client_id});
}

/// Settings for Firebase Authentication in the official Android application
class FirebaseAuthenticationSettingsAndroid extends FirebaseAuthenticationSettings {
  String get tdType => 'firebaseAuthenticationSettingsAndroid';

  FirebaseAuthenticationSettingsAndroid({
    super.extra,
    super.client_id,
  });

  FirebaseAuthenticationSettingsAndroid.fromMap(Map<String, dynamic> map) {
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

/// Settings for Firebase Authentication in the official iOS application
class FirebaseAuthenticationSettingsIos extends FirebaseAuthenticationSettings {
  String get tdType => 'firebaseAuthenticationSettingsIos';

  /// Device token from Apple Push Notification service
  string? device_token;

  /// True, if App Sandbox is enabled
  Bool? is_app_sandbox;

  FirebaseAuthenticationSettingsIos({
    super.extra,
    super.client_id,
    this.device_token,
    this.is_app_sandbox,
  });

  FirebaseAuthenticationSettingsIos.fromMap(Map<String, dynamic> map) {
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
