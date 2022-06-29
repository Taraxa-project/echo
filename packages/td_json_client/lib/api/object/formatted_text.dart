import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/text_entity.dart';


/// A text with some entities 
class FormattedText extends TdObject {
  String get tdType => 'formattedText';

  String? extra;
  int? client_id;

  /// The text 
  string? text;

  /// Entities contained in the text. Entities can be nested, but must not mutually intersect with each other.
  /// Pre, Code and PreCode entities can't contain other entities. Bold, Italic, Underline, Strikethrough, and Spoiler entities can contain and to be contained in all other entities. All other entities can't contain each other
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
    if (map['entities'] != null) {
      entities = [];
      for (var someValue in map['entities']) {
        if (someValue != null) {
          entities?.add(TdApiMap.fromMap(someValue) as TextEntity);
        }
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
