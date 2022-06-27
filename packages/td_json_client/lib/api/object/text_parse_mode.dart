import 'package:td_json_client/api/base.dart';

abstract class TextParseMode extends TdObject {}

class TextParseModeMarkdown extends TextParseMode {
  String get tdType => 'textParseModeMarkdown';

  String? extra;
  int? client_id;
  int32? version;

  TextParseModeMarkdown({
    this.extra,
    this.client_id,
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
class TextParseModeHTML extends TextParseMode {
  String get tdType => 'textParseModeHTML';

  String? extra;
  int? client_id;

  TextParseModeHTML({
    this.extra,
    this.client_id,
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
