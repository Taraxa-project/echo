import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/log_stream.dart';

/// Sets new log stream for internal logging of TDLib. Can be called synchronously
class SetLogStream extends TdFunction {
  String get tdType => 'setLogStream';
  String get tdReturnType => 'Ok';

  /// New log stream
  LogStream? log_stream;

  SetLogStream({
    super.extra,
    super.client_id,
    this.log_stream,
  });

  SetLogStream.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['log_stream'] != null) {
      log_stream = TdApiMap.fromMap(map['log_stream']) as LogStream;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'log_stream': log_stream?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
