import 'package:td_json_client/api/base.dart';

abstract class NotificationSettingsScope extends TdObject {}

class NotificationSettingsScopePrivateChats extends NotificationSettingsScope {
  String get tdType => 'notificationSettingsScopePrivateChats';

  String? extra;
  int? client_id;

  NotificationSettingsScopePrivateChats({
    this.extra,
    this.client_id,
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
class NotificationSettingsScopeGroupChats extends NotificationSettingsScope {
  String get tdType => 'notificationSettingsScopeGroupChats';

  String? extra;
  int? client_id;

  NotificationSettingsScopeGroupChats({
    this.extra,
    this.client_id,
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
class NotificationSettingsScopeChannelChats extends NotificationSettingsScope {
  String get tdType => 'notificationSettingsScopeChannelChats';

  String? extra;
  int? client_id;

  NotificationSettingsScopeChannelChats({
    this.extra,
    this.client_id,
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
