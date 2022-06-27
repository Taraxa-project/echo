import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_file.dart';

class SendCallLog extends TdFunction {
  String get tdType => 'sendCallLog';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  int32? call_id;
  InputFile? log_file;

  SendCallLog({
    this.extra,
    this.client_id,
    this.call_id,
    this.log_file,
  });

  SendCallLog.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    call_id = map['call_id'];
    log_file = TdApiMap.fromMap(map['log_file']) as InputFile;
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
