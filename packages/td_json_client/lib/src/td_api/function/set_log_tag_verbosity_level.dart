import 'package:td_json_client/src/td_api/td.dart';

/// Sets the verbosity level for a specified TDLib internal log tag. Can be called synchronously
class SetLogTagVerbosityLevel extends TdFunction {
  String get tdType => 'setLogTagVerbosityLevel';
  String get tdReturnType => 'Ok';

  /// Logging tag to change verbosity level
  string? tag;

  /// New verbosity level; 1-1024
  int32? new_verbosity_level;

  SetLogTagVerbosityLevel({
    super.extra,
    super.client_id,
    this.tag,
    this.new_verbosity_level,
  });

  SetLogTagVerbosityLevel.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    tag = map['tag'];
    new_verbosity_level = map['new_verbosity_level'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'tag': tag?.toMap(skipNulls: skipNulls),
      'new_verbosity_level': new_verbosity_level?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}