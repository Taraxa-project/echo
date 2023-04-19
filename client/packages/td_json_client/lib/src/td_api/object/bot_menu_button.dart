import 'package:td_json_client/src/td_api/td.dart';

/// Describes a button to be shown instead of bot commands menu button
class BotMenuButton extends TdObject {
  String get tdType => 'botMenuButton';

  /// Text of the button
  string? text;

  /// URL to be passed to openWebApp
  string? url;

  BotMenuButton({
    super.extra,
    super.client_id,
    this.text,
    this.url,
  });

  BotMenuButton.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
    url = map['url'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
