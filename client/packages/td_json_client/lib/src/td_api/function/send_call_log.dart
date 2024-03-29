import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/input_file.dart';

/// Sends log file for a call to Telegram servers
class SendCallLog extends TdFunction {
  String get tdType => 'sendCallLog';
  String get tdReturnType => 'Ok';

  /// Call identifier
  int32? call_id;

  /// Call log file. Only inputFileLocal and inputFileGenerated are supported
  InputFile? log_file;

  SendCallLog({
    super.extra,
    super.client_id,
    this.call_id,
    this.log_file,
  });

  SendCallLog.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    call_id = map['call_id'];
    if (map['log_file'] != null) {
      log_file = TdApiMap.fromMap(map['log_file']) as InputFile;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'call_id': call_id?.toMap(skipNulls: skipNulls),
      'log_file': log_file?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
