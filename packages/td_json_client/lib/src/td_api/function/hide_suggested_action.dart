import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/suggested_action.dart';

/// Hides a suggested action
class HideSuggestedAction extends TdFunction {
  String get tdType => 'hideSuggestedAction';
  String get tdReturnType => 'Ok';

  /// Suggested action to hide
  SuggestedAction? action;

  HideSuggestedAction({
    super.extra,
    super.client_id,
    this.action,
  });

  HideSuggestedAction.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['action'] != null) {
      action = TdApiMap.fromMap(map['action']) as SuggestedAction;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'action': action?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
