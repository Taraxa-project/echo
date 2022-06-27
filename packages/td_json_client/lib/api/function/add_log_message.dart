import 'package:td_json_client/api/base.dart';

class AddLogMessage extends TdFunction {
  String get tdType => 'addLogMessage';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  int32? verbosity_level;
  string? text;

  AddLogMessage({
    this.extra,
    this.client_id,
    this.verbosity_level,
    this.text,
  });

  AddLogMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    verbosity_level = map['verbosity_level'];
    text = map['text'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'verbosity_level': verbosity_level?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
