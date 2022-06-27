import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/location.dart';

class Venue extends TdObject {
  String get tdType => 'venue';

  String? extra;
  int? client_id;
  Location? location;
  string? title;
  string? address;
  string? provider;
  string? id;
  string? type;

  Venue({
    this.extra,
    this.client_id,
    this.location,
    this.title,
    this.address,
    this.provider,
    this.id,
    this.type,
  });

  Venue.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    location = TdApiMap.fromMap(map['location']) as Location;
    title = map['title'];
    address = map['address'];
    provider = map['provider'];
    id = map['id'];
    type = map['type'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'location': location?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'address': address?.toMap(skipNulls: skipNulls),
      'provider': provider?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
