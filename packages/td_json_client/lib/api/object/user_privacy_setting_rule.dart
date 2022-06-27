import 'package:td_json_client/api/base.dart';

abstract class UserPrivacySettingRule extends TdObject {}

class UserPrivacySettingRuleAllowAll extends UserPrivacySettingRule {
  String get tdType => 'userPrivacySettingRuleAllowAll';

  string? extra;
  int? client_id;

  UserPrivacySettingRuleAllowAll({
    this.extra,
    this.client_id,
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
class UserPrivacySettingRuleAllowContacts extends UserPrivacySettingRule {
  String get tdType => 'userPrivacySettingRuleAllowContacts';

  string? extra;
  int? client_id;

  UserPrivacySettingRuleAllowContacts({
    this.extra,
    this.client_id,
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
class UserPrivacySettingRuleAllowUsers extends UserPrivacySettingRule {
  String get tdType => 'userPrivacySettingRuleAllowUsers';

  string? extra;
  int? client_id;
  vector<int53>? user_ids;

  UserPrivacySettingRuleAllowUsers({
    this.extra,
    this.client_id,
    this.user_ids,
  });

  UserPrivacySettingRuleAllowUsers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['user_ids']) {
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
class UserPrivacySettingRuleAllowChatMembers extends UserPrivacySettingRule {
  String get tdType => 'userPrivacySettingRuleAllowChatMembers';

  string? extra;
  int? client_id;
  vector<int53>? chat_ids;

  UserPrivacySettingRuleAllowChatMembers({
    this.extra,
    this.client_id,
    this.chat_ids,
  });

  UserPrivacySettingRuleAllowChatMembers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['chat_ids']) {
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
class UserPrivacySettingRuleRestrictAll extends UserPrivacySettingRule {
  String get tdType => 'userPrivacySettingRuleRestrictAll';

  string? extra;
  int? client_id;

  UserPrivacySettingRuleRestrictAll({
    this.extra,
    this.client_id,
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
class UserPrivacySettingRuleRestrictContacts extends UserPrivacySettingRule {
  String get tdType => 'userPrivacySettingRuleRestrictContacts';

  string? extra;
  int? client_id;

  UserPrivacySettingRuleRestrictContacts({
    this.extra,
    this.client_id,
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
class UserPrivacySettingRuleRestrictUsers extends UserPrivacySettingRule {
  String get tdType => 'userPrivacySettingRuleRestrictUsers';

  string? extra;
  int? client_id;
  vector<int53>? user_ids;

  UserPrivacySettingRuleRestrictUsers({
    this.extra,
    this.client_id,
    this.user_ids,
  });

  UserPrivacySettingRuleRestrictUsers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['user_ids']) {
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
class UserPrivacySettingRuleRestrictChatMembers extends UserPrivacySettingRule {
  String get tdType => 'userPrivacySettingRuleRestrictChatMembers';

  string? extra;
  int? client_id;
  vector<int53>? chat_ids;

  UserPrivacySettingRuleRestrictChatMembers({
    this.extra,
    this.client_id,
    this.chat_ids,
  });

  UserPrivacySettingRuleRestrictChatMembers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['chat_ids']) {
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
