import 'package:td_json_client/api/base.dart';

/// Describes the type of notifications in a notification group
abstract class NotificationGroupType extends TdObject {
  NotificationGroupType({super.extra, super.client_id});
}


/// A group containing notifications of type notificationTypeNewMessage and notificationTypeNewPushMessage with ordinary unread messages
class NotificationGroupTypeMessages extends NotificationGroupType {
  String get tdType => 'notificationGroupTypeMessages';


  NotificationGroupTypeMessages({
    super.extra,
    super.client_id,
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

/// A group containing notifications of type notificationTypeNewMessage and notificationTypeNewPushMessage with unread mentions of the current user, replies to their messages, or a pinned message
class NotificationGroupTypeMentions extends NotificationGroupType {
  String get tdType => 'notificationGroupTypeMentions';


  NotificationGroupTypeMentions({
    super.extra,
    super.client_id,
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

/// A group containing a notification of type notificationTypeNewSecretChat
class NotificationGroupTypeSecretChat extends NotificationGroupType {
  String get tdType => 'notificationGroupTypeSecretChat';


  NotificationGroupTypeSecretChat({
    super.extra,
    super.client_id,
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

/// A group containing notifications of type notificationTypeNewCall
class NotificationGroupTypeCalls extends NotificationGroupType {
  String get tdType => 'notificationGroupTypeCalls';


  NotificationGroupTypeCalls({
    super.extra,
    super.client_id,
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
