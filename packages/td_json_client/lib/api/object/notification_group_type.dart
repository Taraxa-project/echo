import 'package:td_json_client/api/base.dart';

abstract class NotificationGroupType extends TdObject {}

class NotificationGroupTypeMessages extends NotificationGroupType {
  String get tdType => 'notificationGroupTypeMessages';

  String? extra;
  int? client_id;

  NotificationGroupTypeMessages({
    this.extra,
    this.client_id,
  });

  NotificationGroupTypeMessages.fromMap(Map<String, dynamic> map) {
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
class NotificationGroupTypeMentions extends NotificationGroupType {
  String get tdType => 'notificationGroupTypeMentions';

  String? extra;
  int? client_id;

  NotificationGroupTypeMentions({
    this.extra,
    this.client_id,
  });

  NotificationGroupTypeMentions.fromMap(Map<String, dynamic> map) {
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
class NotificationGroupTypeSecretChat extends NotificationGroupType {
  String get tdType => 'notificationGroupTypeSecretChat';

  String? extra;
  int? client_id;

  NotificationGroupTypeSecretChat({
    this.extra,
    this.client_id,
  });

  NotificationGroupTypeSecretChat.fromMap(Map<String, dynamic> map) {
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
class NotificationGroupTypeCalls extends NotificationGroupType {
  String get tdType => 'notificationGroupTypeCalls';

  String? extra;
  int? client_id;

  NotificationGroupTypeCalls({
    this.extra,
    this.client_id,
  });

  NotificationGroupTypeCalls.fromMap(Map<String, dynamic> map) {
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
