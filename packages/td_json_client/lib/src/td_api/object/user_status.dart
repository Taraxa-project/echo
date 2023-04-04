import 'package:td_json_client/src/td_api/td.dart';

/// Describes the last time the user was online
abstract class UserStatus extends TdObject {
  UserStatus({super.extra, super.client_id});
}

/// The user status was never changed
class UserStatusEmpty extends UserStatus {
  String get tdType => 'userStatusEmpty';

  UserStatusEmpty({
    super.extra,
    super.client_id,
  });

  UserStatusEmpty.fromMap(Map<String, dynamic> map) {
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

/// The user is online
class UserStatusOnline extends UserStatus {
  String get tdType => 'userStatusOnline';

  /// Point in time (Unix timestamp) when the user's online status will expire
  int32? expires;

  UserStatusOnline({
    super.extra,
    super.client_id,
    this.expires,
  });

  UserStatusOnline.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    expires = map['expires'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'expires': expires?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The user is offline
class UserStatusOffline extends UserStatus {
  String get tdType => 'userStatusOffline';

  /// Point in time (Unix timestamp) when the user was last online
  int32? was_online;

  UserStatusOffline({
    super.extra,
    super.client_id,
    this.was_online,
  });

  UserStatusOffline.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    was_online = map['was_online'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'was_online': was_online?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The user was online recently
class UserStatusRecently extends UserStatus {
  String get tdType => 'userStatusRecently';

  UserStatusRecently({
    super.extra,
    super.client_id,
  });

  UserStatusRecently.fromMap(Map<String, dynamic> map) {
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

/// The user is offline, but was online last week
class UserStatusLastWeek extends UserStatus {
  String get tdType => 'userStatusLastWeek';

  UserStatusLastWeek({
    super.extra,
    super.client_id,
  });

  UserStatusLastWeek.fromMap(Map<String, dynamic> map) {
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

/// The user is offline, but was online last month
class UserStatusLastMonth extends UserStatus {
  String get tdType => 'userStatusLastMonth';

  UserStatusLastMonth({
    super.extra,
    super.client_id,
  });

  UserStatusLastMonth.fromMap(Map<String, dynamic> map) {
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