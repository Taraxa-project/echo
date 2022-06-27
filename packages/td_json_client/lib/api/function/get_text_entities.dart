import 'package:td_json_client/api/base.dart';

class GetTextEntities extends TdFunction {
  String get tdType => 'getTextEntities';
  String get tdReturnType => 'TextEntities';

  String? extra;
  int? client_id;
  string? text;

  GetTextEntities({
    this.extra,
    this.client_id,
    this.text,
  });

  GetTextEntities.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
