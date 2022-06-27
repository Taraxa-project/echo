import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/text_entity.dart';

class FormattedText extends TdObject {
  String get tdType => 'formattedText';

  String? extra;
  int? client_id;
  string? text;
  vector<TextEntity>? entities;

  FormattedText({
    this.extra,
    this.client_id,
    this.text,
    this.entities,
  });

  FormattedText.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
    if (map['entities']) {
      entities = [];
      for (var someValue in map['entities']) {
        entities?.add(TdApiMap.fromMap(someValue) as TextEntity);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
      'entities': entities?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
