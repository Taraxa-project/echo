import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/country_info.dart';

/// Contains information about countries
class Countries extends TdObject {
  String get tdType => 'countries';

  /// The list of countries
  vector<CountryInfo>? countries;

  Countries({
    super.extra,
    super.client_id,
    this.countries,
  });

  Countries.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['countries'] != null) {
      countries = [];
      for (var someValue in map['countries']) {
        if (someValue != null) {
          countries?.add(TdApiMap.fromMap(someValue) as CountryInfo);
        }
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
