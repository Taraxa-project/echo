import 'package:td_json_client/src/td_api/td.dart';

/// Reports messages in a supergroup as spam; requires administrator rights in the supergroup
class ReportSupergroupSpam extends TdFunction {
  String get tdType => 'reportSupergroupSpam';
  String get tdReturnType => 'Ok';

  /// Supergroup identifier
  int53? supergroup_id;

  /// Identifiers of messages to report
  vector<int53>? message_ids;

  ReportSupergroupSpam({
    super.extra,
    super.client_id,
    this.supergroup_id,
    this.message_ids,
  });

  ReportSupergroupSpam.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    supergroup_id = map['supergroup_id'];
    if (map['message_ids'] != null) {
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
