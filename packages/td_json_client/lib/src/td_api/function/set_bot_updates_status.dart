import 'package:td_json_client/src/td_api/td.dart';

/// Informs the server about the number of pending bot updates if they haven't been processed for a long time; for bots only
class SetBotUpdatesStatus extends TdFunction {
  String get tdType => 'setBotUpdatesStatus';
  String get tdReturnType => 'Ok';

  /// The number of pending updates
  int32? pending_update_count;

  /// The last error message
  string? error_message;

  SetBotUpdatesStatus({
    super.extra,
    super.client_id,
    this.pending_update_count,
    this.error_message,
  });

  SetBotUpdatesStatus.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    pending_update_count = map['pending_update_count'];
    error_message = map['error_message'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'pending_update_count': pending_update_count?.toMap(skipNulls: skipNulls),
      'error_message': error_message?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}