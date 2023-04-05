import 'package:td_json_client/src/td_api/td.dart';

/// Describes available user privacy settings
abstract class UserPrivacySetting extends TdObject {
  UserPrivacySetting({super.extra, super.client_id});
}

/// A privacy setting for managing whether the user's online status is visible
class UserPrivacySettingShowStatus extends UserPrivacySetting {
  String get tdType => 'userPrivacySettingShowStatus';

  UserPrivacySettingShowStatus({
    super.extra,
    super.client_id,
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

  UserPrivacySettingShowProfilePhoto({
    super.extra,
    super.client_id,
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

  UserPrivacySettingShowLinkInForwardedMessages({
    super.extra,
    super.client_id,
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

  UserPrivacySettingShowPhoneNumber({
    super.extra,
    super.client_id,
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

  UserPrivacySettingAllowChatInvites({
    super.extra,
    super.client_id,
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

  UserPrivacySettingAllowCalls({
    super.extra,
    super.client_id,
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

  UserPrivacySettingAllowPeerToPeerCalls({
    super.extra,
    super.client_id,
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

  UserPrivacySettingAllowFindingByPhoneNumber({
    super.extra,
    super.client_id,
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

/// A privacy setting for managing whether the user can receive voice and video messages in private chats
class UserPrivacySettingAllowPrivateVoiceAndVideoNoteMessages extends UserPrivacySetting {
  String get tdType => 'userPrivacySettingAllowPrivateVoiceAndVideoNoteMessages';

  UserPrivacySettingAllowPrivateVoiceAndVideoNoteMessages({
    super.extra,
    super.client_id,
  });

  UserPrivacySettingAllowPrivateVoiceAndVideoNoteMessages.fromMap(Map<String, dynamic> map) {
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
