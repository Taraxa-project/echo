import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/t_me_url_type.dart';

/// Represents a URL linking to an internal Telegram entity
class TMeUrl extends TdObject {
  String get tdType => 'tMeUrl';

  /// URL
  string? url;

  /// Type of the URL
  TMeUrlType? type;

  TMeUrl({
    super.extra,
    super.client_id,
    this.url,
    this.type,
  });

  TMeUrl.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    url = map['url'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as TMeUrlType;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
