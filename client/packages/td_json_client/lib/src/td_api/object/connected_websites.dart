import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/connected_website.dart';

/// Contains a list of websites the current user is logged in with Telegram
class ConnectedWebsites extends TdObject {
  String get tdType => 'connectedWebsites';

  /// List of connected websites
  vector<ConnectedWebsite>? websites;

  ConnectedWebsites({
    super.extra,
    super.client_id,
    this.websites,
  });

  ConnectedWebsites.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['websites'] != null) {
      websites = [];
      for (var someValue in map['websites']) {
        if (someValue != null) {
          websites?.add(TdApiMap.fromMap(someValue) as ConnectedWebsite);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'websites': websites?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
