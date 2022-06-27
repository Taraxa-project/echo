import 'package:td_json_client/api/base.dart';

abstract class CheckChatUsernameResult extends TdObject {}

class CheckChatUsernameResultOk extends CheckChatUsernameResult {
  String get tdType => 'checkChatUsernameResultOk';

  string? extra;
  int? client_id;

  CheckChatUsernameResultOk({
    this.extra,
    this.client_id,
  });

  CheckChatUsernameResultOk.fromMap(Map<String, dynamic> map) {
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
class CheckChatUsernameResultUsernameInvalid extends CheckChatUsernameResult {
  String get tdType => 'checkChatUsernameResultUsernameInvalid';

  string? extra;
  int? client_id;

  CheckChatUsernameResultUsernameInvalid({
    this.extra,
    this.client_id,
  });

  CheckChatUsernameResultUsernameInvalid.fromMap(Map<String, dynamic> map) {
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
class CheckChatUsernameResultUsernameOccupied extends CheckChatUsernameResult {
  String get tdType => 'checkChatUsernameResultUsernameOccupied';

  string? extra;
  int? client_id;

  CheckChatUsernameResultUsernameOccupied({
    this.extra,
    this.client_id,
  });

  CheckChatUsernameResultUsernameOccupied.fromMap(Map<String, dynamic> map) {
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
class CheckChatUsernameResultPublicChatsTooMuch extends CheckChatUsernameResult {
  String get tdType => 'checkChatUsernameResultPublicChatsTooMuch';

  string? extra;
  int? client_id;

  CheckChatUsernameResultPublicChatsTooMuch({
    this.extra,
    this.client_id,
  });

  CheckChatUsernameResultPublicChatsTooMuch.fromMap(Map<String, dynamic> map) {
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
class CheckChatUsernameResultPublicGroupsUnavailable extends CheckChatUsernameResult {
  String get tdType => 'checkChatUsernameResultPublicGroupsUnavailable';

  string? extra;
  int? client_id;

  CheckChatUsernameResultPublicGroupsUnavailable({
    this.extra,
    this.client_id,
  });

  CheckChatUsernameResultPublicGroupsUnavailable.fromMap(Map<String, dynamic> map) {
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