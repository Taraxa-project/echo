import 'package:td_json_client/api/base.dart';

class ReportSupergroupSpam extends TdFunction {
  String get tdType => 'reportSupergroupSpam';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  int53? supergroup_id;
  vector<int53>? message_ids;

  ReportSupergroupSpam({
    this.extra,
    this.client_id,
    this.supergroup_id,
    this.message_ids,
  });

  ReportSupergroupSpam.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    supergroup_id = map['supergroup_id'];
    if (map['message_ids']) {
      message_ids = [];
      for (var someValue in map['message_ids']) {
        message_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'supergroup_id': supergroup_id?.toMap(skipNulls: skipNulls),
      'message_ids': message_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
