import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/formatted_text.dart';

/// Returns a web page preview by the text of the message. Do not call this function too often. Returns a 404 error if the web page has no preview
class GetWebPagePreview extends TdFunction {
  String get tdType => 'getWebPagePreview';
  String get tdReturnType => 'WebPage';

  /// Message text with formatting
  FormattedText? text;

  GetWebPagePreview({
    super.extra,
    super.client_id,
    this.text,
  });

  GetWebPagePreview.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['text'] != null) {
      text = TdApiMap.fromMap(map['text']) as FormattedText;
    }
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
