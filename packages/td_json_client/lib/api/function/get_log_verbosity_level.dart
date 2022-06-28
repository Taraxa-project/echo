import 'package:td_json_client/api/base.dart';


/// Returns current verbosity level of the internal logging of TDLib. Can be called synchronously
class GetLogVerbosityLevel extends TdFunction {
  String get tdType => 'getLogVerbosityLevel';
  String get tdReturnType => 'LogVerbosityLevel';

  String? extra;
  int? client_id;

  GetLogVerbosityLevel({
    this.extra,
    this.client_id,
  });

  GetLogVerbosityLevel.fromMap(Map<String, dynamic> map) {
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
