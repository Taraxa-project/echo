import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/proxy.dart';


/// Represents a list of proxy servers 
class Proxies extends TdObject {
  String get tdType => 'proxies';

  String? extra;
  int? client_id;

  /// List of proxy servers
  vector<Proxy>? proxies;

  Proxies({
    this.extra,
    this.client_id,
    this.proxies,
  });

  Proxies.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['proxies']) {
      proxies = [];
      for (var someValue in map['proxies']) {
        proxies?.add(TdApiMap.fromMap(someValue) as Proxy);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'proxies': proxies?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
