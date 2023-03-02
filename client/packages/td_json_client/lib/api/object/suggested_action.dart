import 'package:td_json_client/api/base.dart';

/// Describes an action suggested to the current user
abstract class SuggestedAction extends TdObject {
  SuggestedAction({super.extra, super.client_id});
}


/// Suggests the user to enable "archive_and_mute_new_chats_from_unknown_users" option
class SuggestedActionEnableArchiveAndMuteNewChats extends SuggestedAction {
  String get tdType => 'suggestedActionEnableArchiveAndMuteNewChats';


  SuggestedActionEnableArchiveAndMuteNewChats({
    super.extra,
    super.client_id,
  });

  SuggestedActionEnableArchiveAndMuteNewChats.fromMap(Map<String, dynamic> map) {
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

/// Suggests the user to check whether they still remember their 2-step verification password
class SuggestedActionCheckPassword extends SuggestedAction {
  String get tdType => 'suggestedActionCheckPassword';


  SuggestedActionCheckPassword({
    super.extra,
    super.client_id,
  });

  SuggestedActionCheckPassword.fromMap(Map<String, dynamic> map) {
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

/// Suggests the user to check whether authorization phone number is correct and change the phone number if it is inaccessible
class SuggestedActionCheckPhoneNumber extends SuggestedAction {
  String get tdType => 'suggestedActionCheckPhoneNumber';


  SuggestedActionCheckPhoneNumber({
    super.extra,
    super.client_id,
  });

  SuggestedActionCheckPhoneNumber.fromMap(Map<String, dynamic> map) {
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

/// Suggests the user to view a hint about the meaning of one and two check marks on sent messages
class SuggestedActionViewChecksHint extends SuggestedAction {
  String get tdType => 'suggestedActionViewChecksHint';


  SuggestedActionViewChecksHint({
    super.extra,
    super.client_id,
  });

  SuggestedActionViewChecksHint.fromMap(Map<String, dynamic> map) {
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

/// Suggests the user to convert specified supergroup to a broadcast group 
class SuggestedActionConvertToBroadcastGroup extends SuggestedAction {
  String get tdType => 'suggestedActionConvertToBroadcastGroup';


  /// Supergroup identifier
  int53? supergroup_id;

  SuggestedActionConvertToBroadcastGroup({
    super.extra,
    super.client_id,
    this.supergroup_id,
  });

  SuggestedActionConvertToBroadcastGroup.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    supergroup_id = map['supergroup_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'supergroup_id': supergroup_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Suggests the user to set a 2-step verification password to be able to log in again 
class SuggestedActionSetPassword extends SuggestedAction {
  String get tdType => 'suggestedActionSetPassword';


  /// The number of days to pass between consecutive authorizations if the user declines to set password
  int32? authorization_delay;

  SuggestedActionSetPassword({
    super.extra,
    super.client_id,
    this.authorization_delay,
  });

  SuggestedActionSetPassword.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    authorization_delay = map['authorization_delay'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'authorization_delay': authorization_delay?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
