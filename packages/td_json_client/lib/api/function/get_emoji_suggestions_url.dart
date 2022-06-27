import 'package:td_json_client/api/base.dart';

class GetEmojiSuggestionsUrl extends TdFunction {
  String get tdType => 'getEmojiSuggestionsUrl';
  String get tdReturnType => 'HttpUrl';

  string? extra;
  int? client_id;
  string? language_code;

  GetEmojiSuggestionsUrl({
    this.extra,
    this.client_id,
    this.language_code,
  });

  GetEmojiSuggestionsUrl.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    language_code = map['language_code'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'language_code': language_code?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
