import 'package:td_json_client/api/base.dart';


/// Contains information about a web app 
class WebAppInfo extends TdObject {
  String get tdType => 'webAppInfo';

  String? extra;
  int? client_id;

  /// Unique identifier for the web app launch 
  int64? launch_id;

  /// A web app URL to open in a web view
  string? url;

  WebAppInfo({
    this.extra,
    this.client_id,
    this.launch_id,
    this.url,
  });

  WebAppInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    launch_id = map['launch_id'];
    url = map['url'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'launch_id': launch_id?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
