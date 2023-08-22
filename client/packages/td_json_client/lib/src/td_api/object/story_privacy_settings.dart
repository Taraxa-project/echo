import 'package:td_json_client/src/td_api/td.dart';

/// Describes privacy settings of a story
abstract class StoryPrivacySettings extends TdObject {
  StoryPrivacySettings({super.extra, super.client_id});
}

/// The story can be viewed by everyone
class StoryPrivacySettingsEveryone extends StoryPrivacySettings {
  String get tdType => 'storyPrivacySettingsEveryone';

  StoryPrivacySettingsEveryone({
    super.extra,
    super.client_id,
  });

  StoryPrivacySettingsEveryone.fromMap(Map<String, dynamic> map) {
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

/// The story can be viewed by all contacts except chosen users
class StoryPrivacySettingsContacts extends StoryPrivacySettings {
  String get tdType => 'storyPrivacySettingsContacts';

  /// User identifiers of the contacts that can't see the story; always empty for non-owned stories
  vector<int53>? except_user_ids;

  StoryPrivacySettingsContacts({
    super.extra,
    super.client_id,
    this.except_user_ids,
  });

  StoryPrivacySettingsContacts.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['except_user_ids'] != null) {
      except_user_ids = [];
      for (var someValue in map['except_user_ids']) {
        except_user_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'except_user_ids': except_user_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The story can be viewed by all close friends
class StoryPrivacySettingsCloseFriends extends StoryPrivacySettings {
  String get tdType => 'storyPrivacySettingsCloseFriends';

  StoryPrivacySettingsCloseFriends({
    super.extra,
    super.client_id,
  });

  StoryPrivacySettingsCloseFriends.fromMap(Map<String, dynamic> map) {
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

/// The story can be viewed by certain specified users
class StoryPrivacySettingsSelectedContacts extends StoryPrivacySettings {
  String get tdType => 'storyPrivacySettingsSelectedContacts';

  /// Identifiers of the users; always empty for non-owned stories
  vector<int53>? user_ids;

  StoryPrivacySettingsSelectedContacts({
    super.extra,
    super.client_id,
    this.user_ids,
  });

  StoryPrivacySettingsSelectedContacts.fromMap(Map<String, dynamic> map) {
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
