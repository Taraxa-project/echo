import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/country_info.dart';

class Countries extends TdObject {
  String get tdType => 'countries';

  string? extra;
  int? client_id;
  vector<CountryInfo>? countries;

  Countries({
    this.extra,
    this.client_id,
    this.countries,
  });

  Countries.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['countries']) {
      countries = [];
      for (var someValue in map['countries']) {
        countries?.add(TdApiMap.fromMap(someValue) as CountryInfo);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'countries': countries?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
