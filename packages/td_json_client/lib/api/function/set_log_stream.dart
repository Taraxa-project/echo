import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/log_stream.dart';

class SetLogStream extends TdFunction {
  String get tdType => 'setLogStream';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  LogStream? log_stream;

  SetLogStream({
    this.extra,
    this.client_id,
    this.log_stream,
  });

  SetLogStream.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    log_stream = TdApiMap.fromMap(map['log_stream']) as LogStream;
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