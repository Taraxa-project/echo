import 'package:td_json_client/api/base.dart';


/// Sets the verbosity level of the internal logging of TDLib. Can be called synchronously
class SetLogVerbosityLevel extends TdFunction {
  String get tdType => 'setLogVerbosityLevel';
  String get tdReturnType => 'Ok';


  /// New value of the verbosity level for logging. Value 0 corresponds to fatal errors, value 1 corresponds to errors, value 2 corresponds to warnings and debug warnings, value 3 corresponds to informational, value 4 corresponds to debug, value 5 corresponds to verbose debug, value greater than 5 and up to 1023 can be used to enable even more logging
  int32? new_verbosity_level;

  SetLogVerbosityLevel({
    super.extra,
    super.client_id,
    this.new_verbosity_level,
  });

  SetLogVerbosityLevel.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    new_verbosity_level = map['new_verbosity_level'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'new_verbosity_level': new_verbosity_level?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
