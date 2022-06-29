import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/connected_website.dart';


/// Contains a list of websites the current user is logged in with Telegram 
class ConnectedWebsites extends TdObject {
  String get tdType => 'connectedWebsites';

  String? extra;
  int? client_id;

  /// List of connected websites
  vector<ConnectedWebsite>? websites;

  ConnectedWebsites({
    this.extra,
    this.client_id,
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
