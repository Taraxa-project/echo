import 'package:td_json_client/api/base.dart';

class BotMenuButton extends TdObject {
  String get tdType => 'botMenuButton';

  string? extra;
  int? client_id;
  string? text;
  string? url;

  BotMenuButton({
    this.extra,
    this.client_id,
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
