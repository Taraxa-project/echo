import 'package:td_json_client/api/base.dart';

class ToggleSupergroupIsAllHistoryAvailable extends TdFunction {
  String get tdType => 'toggleSupergroupIsAllHistoryAvailable';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int53? supergroup_id;
  Bool? is_all_history_available;

  ToggleSupergroupIsAllHistoryAvailable({
    this.extra,
    this.client_id,
    this.supergroup_id,
    this.is_all_history_available,
  });

  ToggleSupergroupIsAllHistoryAvailable.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    supergroup_id = map['supergroup_id'];
    is_all_history_available = map['is_all_history_available'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'supergroup_id': supergroup_id?.toMap(skipNulls: skipNulls),
      'is_all_history_available': is_all_history_available?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
