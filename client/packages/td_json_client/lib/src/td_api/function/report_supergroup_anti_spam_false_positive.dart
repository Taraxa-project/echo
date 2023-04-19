import 'package:td_json_client/src/td_api/td.dart';

/// Reports a false deletion of a message by aggressive anti-spam checks; requires administrator rights in the supergroup. Can be called only for messages from chatEventMessageDeleted with can_report_anti_spam_false_positive == true
class ReportSupergroupAntiSpamFalsePositive extends TdFunction {
  String get tdType => 'reportSupergroupAntiSpamFalsePositive';
  String get tdReturnType => 'Ok';

  /// Supergroup identifier
  int53? supergroup_id;

  /// Identifier of the erroneously deleted message
  int53? message_id;

  ReportSupergroupAntiSpamFalsePositive({
    super.extra,
    super.client_id,
    this.supergroup_id,
    this.message_id,
  });

  ReportSupergroupAntiSpamFalsePositive.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    supergroup_id = map['supergroup_id'];
    message_id = map['message_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'supergroup_id': supergroup_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
