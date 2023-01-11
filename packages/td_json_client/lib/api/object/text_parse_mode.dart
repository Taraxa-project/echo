import 'package:td_json_client/api/base.dart';

/// Describes the way the text needs to be parsed for text entities
abstract class TextParseMode extends TdObject {
  TextParseMode({super.extra, super.client_id});
}


/// The text uses Markdown-style formatting
class TextParseModeMarkdown extends TextParseMode {
  String get tdType => 'textParseModeMarkdown';


  /// Version of the parser: 0 or 1 - Telegram Bot API "Markdown" parse mode, 2 - Telegram Bot API "MarkdownV2" parse mode
  int32? version;

  TextParseModeMarkdown({
    super.extra,
    super.client_id,
    this.version,
  });

  TextParseModeMarkdown.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    version = map['version'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'version': version?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The text uses HTML-style formatting. The same as Telegram Bot API "HTML" parse mode
class TextParseModeHTML extends TextParseMode {
  String get tdType => 'textParseModeHTML';


  TextParseModeHTML({
    super.extra,
    super.client_id,
  });

  TextParseModeHTML.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
