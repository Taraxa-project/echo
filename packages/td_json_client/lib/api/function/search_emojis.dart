import 'package:td_json_client/api/base.dart';

class SearchEmojis extends TdFunction {
  String get tdType => 'searchEmojis';
  String get tdReturnType => 'Emojis';

  string? extra;
  int? client_id;
  string? text;
  Bool? exact_match;
  vector<string>? input_language_codes;

  SearchEmojis({
    this.extra,
    this.client_id,
    this.text,
    this.exact_match,
    this.input_language_codes,
  });

  SearchEmojis.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
    exact_match = map['exact_match'];
    if (map['input_language_codes']) {
      input_language_codes = [];
      for (var someValue in map['input_language_codes']) {
        input_language_codes?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
      'exact_match': exact_match?.toMap(skipNulls: skipNulls),
      'input_language_codes': input_language_codes?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
