import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/suggested_action.dart';

class HideSuggestedAction extends TdFunction {
  String get tdType => 'hideSuggestedAction';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  SuggestedAction? action;

  HideSuggestedAction({
    this.extra,
    this.client_id,
    this.action,
  });

  HideSuggestedAction.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    action = TdApiMap.fromMap(map['action']) as SuggestedAction;
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
