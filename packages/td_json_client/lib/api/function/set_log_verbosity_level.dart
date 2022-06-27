import 'package:td_json_client/api/base.dart';

class SetLogVerbosityLevel extends TdFunction {
  String get tdType => 'setLogVerbosityLevel';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  int32? new_verbosity_level;

  SetLogVerbosityLevel({
    this.extra,
    this.client_id,
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
