import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/scope_autosave_settings.dart';

/// Contains autosave settings for a chat, which overrides default settings for the corresponding scope
class AutosaveSettingsException extends TdObject {
  String get tdType => 'autosaveSettingsException';

  /// Chat identifier
  int53? chat_id;

  /// Autosave settings for the chat
  ScopeAutosaveSettings? settings;

  AutosaveSettingsException({
    super.extra,
    super.client_id,
    this.chat_id,
    this.settings,
  });

  AutosaveSettingsException.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['settings'] != null) {
      settings = TdApiMap.fromMap(map['settings']) as ScopeAutosaveSettings;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'settings': settings?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
