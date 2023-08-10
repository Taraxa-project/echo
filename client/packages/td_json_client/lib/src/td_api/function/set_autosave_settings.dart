import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/autosave_settings_scope.dart';
import 'package:td_json_client/src/td_api/object/scope_autosave_settings.dart';

/// Sets autosave settings for the given scope. The method is guaranteed to work only after at least one call to getAutosaveSettings
class SetAutosaveSettings extends TdFunction {
  String get tdType => 'setAutosaveSettings';
  String get tdReturnType => 'Ok';

  /// Autosave settings scope
  AutosaveSettingsScope? scope;

  /// New autosave settings for the scope; pass null to set autosave settings to default
  ScopeAutosaveSettings? settings;

  SetAutosaveSettings({
    super.extra,
    super.client_id,
    this.scope,
    this.settings,
  });

  SetAutosaveSettings.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['scope'] != null) {
      scope = TdApiMap.fromMap(map['scope']) as AutosaveSettingsScope;
    }
    if (map['settings'] != null) {
      settings = TdApiMap.fromMap(map['settings']) as ScopeAutosaveSettings;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'scope': scope?.toMap(skipNulls: skipNulls),
      'settings': settings?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
