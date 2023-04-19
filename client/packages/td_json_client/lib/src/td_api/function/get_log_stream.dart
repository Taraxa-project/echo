import 'package:td_json_client/src/td_api/td.dart';

/// Returns information about currently used log stream for internal logging of TDLib. Can be called synchronously
class GetLogStream extends TdFunction {
  String get tdType => 'getLogStream';
  String get tdReturnType => 'LogStream';

  GetLogStream({
    super.extra,
    super.client_id,
  });

  GetLogStream.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
