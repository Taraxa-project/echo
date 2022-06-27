import 'package:td_json_client/api/base.dart';

class SendCallDebugInformation extends TdFunction {
  String get tdType => 'sendCallDebugInformation';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  int32? call_id;
  string? debug_information;

  SendCallDebugInformation({
    this.extra,
    this.client_id,
    this.call_id,
    this.debug_information,
  });

  SendCallDebugInformation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    call_id = map['call_id'];
    debug_information = map['debug_information'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'call_id': call_id?.toMap(skipNulls: skipNulls),
      'debug_information': debug_information?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
