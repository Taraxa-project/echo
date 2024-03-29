import 'package:td_json_client/src/td_api/td.dart';

/// Contains an HTTP URL
class HttpUrl extends TdObject {
  String get tdType => 'httpUrl';

  /// The URL
  string? url;

  HttpUrl({
    super.extra,
    super.client_id,
    this.url,
  });

  HttpUrl.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    url = map['url'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
