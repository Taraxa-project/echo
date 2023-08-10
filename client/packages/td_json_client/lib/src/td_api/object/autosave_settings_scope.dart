import 'package:td_json_client/src/td_api/td.dart';

/// Describes scope of autosave settings
abstract class AutosaveSettingsScope extends TdObject {
  AutosaveSettingsScope({super.extra, super.client_id});
}

/// Autosave settings applied to all private chats without chat-specific settings
class AutosaveSettingsScopePrivateChats extends AutosaveSettingsScope {
  String get tdType => 'autosaveSettingsScopePrivateChats';

  AutosaveSettingsScopePrivateChats({
    super.extra,
    super.client_id,
  });

  AutosaveSettingsScopePrivateChats.fromMap(Map<String, dynamic> map) {
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

/// Autosave settings applied to all basic group and supergroup chats without chat-specific settings
class AutosaveSettingsScopeGroupChats extends AutosaveSettingsScope {
  String get tdType => 'autosaveSettingsScopeGroupChats';

  AutosaveSettingsScopeGroupChats({
    super.extra,
    super.client_id,
  });

  AutosaveSettingsScopeGroupChats.fromMap(Map<String, dynamic> map) {
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

/// Autosave settings applied to all channel chats without chat-specific settings
class AutosaveSettingsScopeChannelChats extends AutosaveSettingsScope {
  String get tdType => 'autosaveSettingsScopeChannelChats';

  AutosaveSettingsScopeChannelChats({
    super.extra,
    super.client_id,
  });

  AutosaveSettingsScopeChannelChats.fromMap(Map<String, dynamic> map) {
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

/// Autosave settings applied to a chat
class AutosaveSettingsScopeChat extends AutosaveSettingsScope {
  String get tdType => 'autosaveSettingsScopeChat';

  /// Chat identifier
  int53? chat_id;

  AutosaveSettingsScopeChat({
    super.extra,
    super.client_id,
    this.chat_id,
  });

  AutosaveSettingsScopeChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
