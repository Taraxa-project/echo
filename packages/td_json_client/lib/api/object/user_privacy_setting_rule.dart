import 'package:td_json_client/api/base.dart';

/// Represents a single rule for managing privacy settings
abstract class UserPrivacySettingRule extends TdObject {
  UserPrivacySettingRule({super.extra, super.client_id});
}


/// A rule to allow all users to do something
class UserPrivacySettingRuleAllowAll extends UserPrivacySettingRule {
  String get tdType => 'userPrivacySettingRuleAllowAll';


  UserPrivacySettingRuleAllowAll({
    super.extra,
    super.client_id,
  });

  UserPrivacySettingRuleAllowAll.fromMap(Map<String, dynamic> map) {
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

/// A rule to allow all of a user's contacts to do something
class UserPrivacySettingRuleAllowContacts extends UserPrivacySettingRule {
  String get tdType => 'userPrivacySettingRuleAllowContacts';


  UserPrivacySettingRuleAllowContacts({
    super.extra,
    super.client_id,
  });

  UserPrivacySettingRuleAllowContacts.fromMap(Map<String, dynamic> map) {
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

/// A rule to allow certain specified users to do something 
class UserPrivacySettingRuleAllowUsers extends UserPrivacySettingRule {
  String get tdType => 'userPrivacySettingRuleAllowUsers';


  /// The user identifiers, total number of users in all rules must not exceed 1000
  vector<int53>? user_ids;

  UserPrivacySettingRuleAllowUsers({
    super.extra,
    super.client_id,
    this.user_ids,
  });

  UserPrivacySettingRuleAllowUsers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['user_ids'] != null) {
      user_ids = [];
      for (var someValue in map['user_ids']) {
        user_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_ids': user_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A rule to allow all members of certain specified basic groups and supergroups to doing something 
class UserPrivacySettingRuleAllowChatMembers extends UserPrivacySettingRule {
  String get tdType => 'userPrivacySettingRuleAllowChatMembers';


  /// The chat identifiers, total number of chats in all rules must not exceed 20
  vector<int53>? chat_ids;

  UserPrivacySettingRuleAllowChatMembers({
    super.extra,
    super.client_id,
    this.chat_ids,
  });

  UserPrivacySettingRuleAllowChatMembers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['chat_ids'] != null) {
      chat_ids = [];
      for (var someValue in map['chat_ids']) {
        chat_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_ids': chat_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A rule to restrict all users from doing something
class UserPrivacySettingRuleRestrictAll extends UserPrivacySettingRule {
  String get tdType => 'userPrivacySettingRuleRestrictAll';


  UserPrivacySettingRuleRestrictAll({
    super.extra,
    super.client_id,
  });

  UserPrivacySettingRuleRestrictAll.fromMap(Map<String, dynamic> map) {
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

/// A rule to restrict all contacts of a user from doing something
class UserPrivacySettingRuleRestrictContacts extends UserPrivacySettingRule {
  String get tdType => 'userPrivacySettingRuleRestrictContacts';


  UserPrivacySettingRuleRestrictContacts({
    super.extra,
    super.client_id,
  });

  UserPrivacySettingRuleRestrictContacts.fromMap(Map<String, dynamic> map) {
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

/// A rule to restrict all specified users from doing something 
class UserPrivacySettingRuleRestrictUsers extends UserPrivacySettingRule {
  String get tdType => 'userPrivacySettingRuleRestrictUsers';


  /// The user identifiers, total number of users in all rules must not exceed 1000
  vector<int53>? user_ids;

  UserPrivacySettingRuleRestrictUsers({
    super.extra,
    super.client_id,
    this.user_ids,
  });

  UserPrivacySettingRuleRestrictUsers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['user_ids'] != null) {
      user_ids = [];
      for (var someValue in map['user_ids']) {
        user_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_ids': user_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A rule to restrict all members of specified basic groups and supergroups from doing something 
class UserPrivacySettingRuleRestrictChatMembers extends UserPrivacySettingRule {
  String get tdType => 'userPrivacySettingRuleRestrictChatMembers';


  /// The chat identifiers, total number of chats in all rules must not exceed 20
  vector<int53>? chat_ids;

  UserPrivacySettingRuleRestrictChatMembers({
    super.extra,
    super.client_id,
    this.chat_ids,
  });

  UserPrivacySettingRuleRestrictChatMembers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['chat_ids'] != null) {
      chat_ids = [];
      for (var someValue in map['chat_ids']) {
        chat_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_ids': chat_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
