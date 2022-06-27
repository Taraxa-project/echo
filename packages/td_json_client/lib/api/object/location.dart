import 'package:td_json_client/api/base.dart';

class Location extends TdObject {
  String get tdType => 'location';

  string? extra;
  int? client_id;
  double? latitude;
  double? longitude;
  double? horizontal_accuracy;

  Location({
    this.extra,
    this.client_id,
    this.latitude,
    this.longitude,
    this.horizontal_accuracy,
  });

  Location.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    latitude = map['latitude'];
    longitude = map['longitude'];
    horizontal_accuracy = map['horizontal_accuracy'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'latitude': latitude?.toMap(skipNulls: skipNulls),
      'longitude': longitude?.toMap(skipNulls: skipNulls),
      'horizontal_accuracy': horizontal_accuracy?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
