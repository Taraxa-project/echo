import 'package:td_json_client/api/base.dart';

abstract class UserStatus extends TdObject {}

class UserStatusEmpty extends UserStatus {
  String get tdType => 'userStatusEmpty';

  String? extra;
  int? client_id;

  UserStatusEmpty({
    this.extra,
    this.client_id,
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
class UserStatusOnline extends UserStatus {
  String get tdType => 'userStatusOnline';

  String? extra;
  int? client_id;
  int32? expires;

  UserStatusOnline({
    this.extra,
    this.client_id,
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
class UserStatusOffline extends UserStatus {
  String get tdType => 'userStatusOffline';

  String? extra;
  int? client_id;
  int32? was_online;

  UserStatusOffline({
    this.extra,
    this.client_id,
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
class UserStatusRecently extends UserStatus {
  String get tdType => 'userStatusRecently';

  String? extra;
  int? client_id;

  UserStatusRecently({
    this.extra,
    this.client_id,
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
class UserStatusLastWeek extends UserStatus {
  String get tdType => 'userStatusLastWeek';

  String? extra;
  int? client_id;

  UserStatusLastWeek({
    this.extra,
    this.client_id,
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
class UserStatusLastMonth extends UserStatus {
  String get tdType => 'userStatusLastMonth';

  String? extra;
  int? client_id;

  UserStatusLastMonth({
    this.extra,
    this.client_id,
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
