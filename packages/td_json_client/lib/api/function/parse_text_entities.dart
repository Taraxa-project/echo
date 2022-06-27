import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/text_parse_mode.dart';

class ParseTextEntities extends TdFunction {
  String get tdType => 'parseTextEntities';
  String get tdReturnType => 'FormattedText';

  string? extra;
  int? client_id;
  string? text;
  TextParseMode? parse_mode;

  ParseTextEntities({
    this.extra,
    this.client_id,
    this.text,
    this.parse_mode,
  });

  ParseTextEntities.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
    parse_mode = TdApiMap.fromMap(map['parse_mode']) as TextParseMode;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
      'parse_mode': parse_mode?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
