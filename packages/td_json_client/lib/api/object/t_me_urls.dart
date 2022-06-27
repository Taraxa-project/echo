import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/t_me_url.dart';

class TMeUrls extends TdObject {
  String get tdType => 'tMeUrls';

  string? extra;
  int? client_id;
  vector<TMeUrl>? urls;

  TMeUrls({
    this.extra,
    this.client_id,
    this.urls,
  });

  TMeUrls.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['urls']) {
      urls = [];
      for (var someValue in map['urls']) {
        urls?.add(TdApiMap.fromMap(someValue) as TMeUrl);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'urls': urls?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
