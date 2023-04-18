import 'package:td_json_client/src/td_api/td.dart';

/// Returns an HTTP URL which can be used to automatically log in to the translation platform and suggest new emoji replacements. The URL will be valid for 30 seconds after generation
class GetEmojiSuggestionsUrl extends TdFunction {
  String get tdType => 'getEmojiSuggestionsUrl';
  String get tdReturnType => 'HttpUrl';

  /// Language code for which the emoji replacements will be suggested
  string? language_code;

  GetEmojiSuggestionsUrl({
    super.extra,
    super.client_id,
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
