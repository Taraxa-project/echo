import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/t_me_url_type.dart';

class TMeUrl extends TdObject {
  String get tdType => 'tMeUrl';

  string? extra;
  int? client_id;
  string? url;
  TMeUrlType? type;

  TMeUrl({
    this.extra,
    this.client_id,
    this.url,
    this.type,
  });

  TMeUrl.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    url = map['url'];
    type = TdApiMap.fromMap(map['type']) as TMeUrlType;
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
