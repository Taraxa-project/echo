import 'package:td_json_client/api/base.dart';


/// Returns current verbosity level for a specified TDLib internal log tag. Can be called synchronously 
class GetLogTagVerbosityLevel extends TdFunction {
  String get tdType => 'getLogTagVerbosityLevel';
  String get tdReturnType => 'LogVerbosityLevel';

  String? extra;
  int? client_id;

  /// Logging tag to change verbosity level
  string? tag;

  GetLogTagVerbosityLevel({
    this.extra,
    this.client_id,
    this.tag,
  });

  GetLogTagVerbosityLevel.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    tag = map['tag'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'tag': tag?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
