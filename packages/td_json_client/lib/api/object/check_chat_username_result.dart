import 'package:td_json_client/api/base.dart';

/// Represents result of checking whether a username can be set for a chat
abstract class CheckChatUsernameResult extends TdObject {
  CheckChatUsernameResult({super.extra, super.client_id});
}


/// The username can be set
class CheckChatUsernameResultOk extends CheckChatUsernameResult {
  String get tdType => 'checkChatUsernameResultOk';


  CheckChatUsernameResultOk({
    super.extra,
    super.client_id,
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

/// The username is invalid
class CheckChatUsernameResultUsernameInvalid extends CheckChatUsernameResult {
  String get tdType => 'checkChatUsernameResultUsernameInvalid';


  CheckChatUsernameResultUsernameInvalid({
    super.extra,
    super.client_id,
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

/// The username is occupied
class CheckChatUsernameResultUsernameOccupied extends CheckChatUsernameResult {
  String get tdType => 'checkChatUsernameResultUsernameOccupied';


  CheckChatUsernameResultUsernameOccupied({
    super.extra,
    super.client_id,
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

/// The user has too much chats with username, one of them must be made private first
class CheckChatUsernameResultPublicChatsTooMuch extends CheckChatUsernameResult {
  String get tdType => 'checkChatUsernameResultPublicChatsTooMuch';


  CheckChatUsernameResultPublicChatsTooMuch({
    super.extra,
    super.client_id,
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

/// The user can't be a member of a public supergroup
class CheckChatUsernameResultPublicGroupsUnavailable extends CheckChatUsernameResult {
  String get tdType => 'checkChatUsernameResultPublicGroupsUnavailable';


  CheckChatUsernameResultPublicGroupsUnavailable({
    super.extra,
    super.client_id,
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
