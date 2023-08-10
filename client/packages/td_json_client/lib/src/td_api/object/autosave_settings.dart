import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/scope_autosave_settings.dart';
import 'package:td_json_client/src/td_api/object/autosave_settings_exception.dart';

/// Describes autosave settings
class AutosaveSettings extends TdObject {
  String get tdType => 'autosaveSettings';

  /// Default autosave settings for private chats
  ScopeAutosaveSettings? private_chat_settings;

  /// Default autosave settings for basic group and supergroup chats
  ScopeAutosaveSettings? group_settings;

  /// Default autosave settings for channel chats
  ScopeAutosaveSettings? channel_settings;

  /// Autosave settings for specific chats
  vector<AutosaveSettingsException>? exceptions;

  AutosaveSettings({
    super.extra,
    super.client_id,
    this.private_chat_settings,
    this.group_settings,
    this.channel_settings,
    this.exceptions,
  });

  AutosaveSettings.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['private_chat_settings'] != null) {
      private_chat_settings = TdApiMap.fromMap(map['private_chat_settings']) as ScopeAutosaveSettings;
    }
    if (map['group_settings'] != null) {
      group_settings = TdApiMap.fromMap(map['group_settings']) as ScopeAutosaveSettings;
    }
    if (map['channel_settings'] != null) {
      channel_settings = TdApiMap.fromMap(map['channel_settings']) as ScopeAutosaveSettings;
    }
    if (map['exceptions'] != null) {
      exceptions = [];
      for (var someValue in map['exceptions']) {
        if (someValue != null) {
          exceptions?.add(TdApiMap.fromMap(someValue) as AutosaveSettingsException);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'private_chat_settings': private_chat_settings?.toMap(skipNulls: skipNulls),
      'group_settings': group_settings?.toMap(skipNulls: skipNulls),
      'channel_settings': channel_settings?.toMap(skipNulls: skipNulls),
      'exceptions': exceptions?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
