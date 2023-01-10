import 'package:td_json_client/api/base.dart';


/// Translates a text to the given language. Returns a 404 error if the translation can't be performed
class TranslateText extends TdFunction {
  String get tdType => 'translateText';
  String get tdReturnType => 'Text';


  /// Text to translate
  string? text;

  /// A two-letter ISO 639-1 language code of the language from which the message is translated. If empty, the language will be detected automatically
  string? from_language_code;

  /// A two-letter ISO 639-1 language code of the language to which the message is translated
  string? to_language_code;

  TranslateText({
    super.extra,
    super.client_id,
    this.text,
    this.from_language_code,
    this.to_language_code,
  });

  TranslateText.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
    from_language_code = map['from_language_code'];
    to_language_code = map['to_language_code'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
      'from_language_code': from_language_code?.toMap(skipNulls: skipNulls),
      'to_language_code': to_language_code?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
