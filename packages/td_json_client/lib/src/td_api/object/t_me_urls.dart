import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/t_me_url.dart';

/// Contains a list of t.me URLs
class TMeUrls extends TdObject {
  String get tdType => 'tMeUrls';

  /// List of URLs
  vector<TMeUrl>? urls;

  TMeUrls({
    super.extra,
    super.client_id,
    this.urls,
  });

  TMeUrls.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['urls'] != null) {
      urls = [];
      for (var someValue in map['urls']) {
        if (someValue != null) {
          urls?.add(TdApiMap.fromMap(someValue) as TMeUrl);
        }
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
