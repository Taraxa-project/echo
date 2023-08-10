import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/inline_query_results_button_type.dart';

/// Represents a button to be shown above inline query results
class InlineQueryResultsButton extends TdObject {
  String get tdType => 'inlineQueryResultsButton';

  /// The text of the button
  string? text;

  /// Type of the button
  InlineQueryResultsButtonType? type;

  InlineQueryResultsButton({
    super.extra,
    super.client_id,
    this.text,
    this.type,
  });

  InlineQueryResultsButton.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as InlineQueryResultsButtonType;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
