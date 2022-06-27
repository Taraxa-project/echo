import 'package:td_json_client/api/base.dart';

/// Describes available user privacy settings
abstract class UserPrivacySetting extends TdObject {}


/// A privacy setting for managing whether the user's online status is visible
class UserPrivacySettingShowStatus extends UserPrivacySetting {
  String get tdType => 'userPrivacySettingShowStatus';

  String? extra;
  int? client_id;

  UserPrivacySettingShowStatus({
    this.extra,
    this.client_id,
  });

  UserPrivacySettingShowStatus.fromMap(Map<String, dynamic> map) {
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

/// A privacy setting for managing whether the user's profile photo is visible
class UserPrivacySettingShowProfilePhoto extends UserPrivacySetting {
  String get tdType => 'userPrivacySettingShowProfilePhoto';

  String? extra;
  int? client_id;

  UserPrivacySettingShowProfilePhoto({
    this.extra,
    this.client_id,
  });

  UserPrivacySettingShowProfilePhoto.fromMap(Map<String, dynamic> map) {
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

/// A privacy setting for managing whether a link to the user's account is included in forwarded messages
class UserPrivacySettingShowLinkInForwardedMessages extends UserPrivacySetting {
  String get tdType => 'userPrivacySettingShowLinkInForwardedMessages';

  String? extra;
  int? client_id;

  UserPrivacySettingShowLinkInForwardedMessages({
    this.extra,
    this.client_id,
  });

  UserPrivacySettingShowLinkInForwardedMessages.fromMap(Map<String, dynamic> map) {
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

/// A privacy setting for managing whether the user's phone number is visible
class UserPrivacySettingShowPhoneNumber extends UserPrivacySetting {
  String get tdType => 'userPrivacySettingShowPhoneNumber';

  String? extra;
  int? client_id;

  UserPrivacySettingShowPhoneNumber({
    this.extra,
    this.client_id,
  });

  UserPrivacySettingShowPhoneNumber.fromMap(Map<String, dynamic> map) {
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

/// A privacy setting for managing whether the user can be invited to chats
class UserPrivacySettingAllowChatInvites extends UserPrivacySetting {
  String get tdType => 'userPrivacySettingAllowChatInvites';

  String? extra;
  int? client_id;

  UserPrivacySettingAllowChatInvites({
    this.extra,
    this.client_id,
  });

  UserPrivacySettingAllowChatInvites.fromMap(Map<String, dynamic> map) {
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

/// A privacy setting for managing whether the user can be called
class UserPrivacySettingAllowCalls extends UserPrivacySetting {
  String get tdType => 'userPrivacySettingAllowCalls';

  String? extra;
  int? client_id;

  UserPrivacySettingAllowCalls({
    this.extra,
    this.client_id,
  });

  UserPrivacySettingAllowCalls.fromMap(Map<String, dynamic> map) {
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

/// A privacy setting for managing whether peer-to-peer connections can be used for calls
class UserPrivacySettingAllowPeerToPeerCalls extends UserPrivacySetting {
  String get tdType => 'userPrivacySettingAllowPeerToPeerCalls';

  String? extra;
  int? client_id;

  UserPrivacySettingAllowPeerToPeerCalls({
    this.extra,
    this.client_id,
  });

  UserPrivacySettingAllowPeerToPeerCalls.fromMap(Map<String, dynamic> map) {
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

/// A privacy setting for managing whether the user can be found by their phone number. Checked only if the phone number is not known to the other user. Can be set only to "Allow contacts" or "Allow all"
class UserPrivacySettingAllowFindingByPhoneNumber extends UserPrivacySetting {
  String get tdType => 'userPrivacySettingAllowFindingByPhoneNumber';

  String? extra;
  int? client_id;

  UserPrivacySettingAllowFindingByPhoneNumber({
    this.extra,
    this.client_id,
  });

  UserPrivacySettingAllowFindingByPhoneNumber.fromMap(Map<String, dynamic> map) {
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
