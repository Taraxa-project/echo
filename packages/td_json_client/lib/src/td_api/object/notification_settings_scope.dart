import 'package:td_json_client/src/td_api/td.dart';

/// Describes the types of chats to which notification settings are relevant
abstract class NotificationSettingsScope extends TdObject {
  NotificationSettingsScope({super.extra, super.client_id});
}

/// Notification settings applied to all private and secret chats when the corresponding chat setting has a default value
class NotificationSettingsScopePrivateChats extends NotificationSettingsScope {
  String get tdType => 'notificationSettingsScopePrivateChats';

  NotificationSettingsScopePrivateChats({
    super.extra,
    super.client_id,
  });

  NotificationSettingsScopePrivateChats.fromMap(Map<String, dynamic> map) {
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

/// Notification settings applied to all basic group and supergroup chats when the corresponding chat setting has a default value
class NotificationSettingsScopeGroupChats extends NotificationSettingsScope {
  String get tdType => 'notificationSettingsScopeGroupChats';

  NotificationSettingsScopeGroupChats({
    super.extra,
    super.client_id,
  });

  NotificationSettingsScopeGroupChats.fromMap(Map<String, dynamic> map) {
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

/// Notification settings applied to all channel chats when the corresponding chat setting has a default value
class NotificationSettingsScopeChannelChats extends NotificationSettingsScope {
  String get tdType => 'notificationSettingsScopeChannelChats';

  NotificationSettingsScopeChannelChats({
    super.extra,
    super.client_id,
  });

  NotificationSettingsScopeChannelChats.fromMap(Map<String, dynamic> map) {
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
