import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/location.dart';


/// Describes a venue
class Venue extends TdObject {
  String get tdType => 'venue';


  /// Venue location; as defined by the sender
  Location? location;

  /// Venue name; as defined by the sender
  string? title;

  /// Venue address; as defined by the sender
  string? address;

  /// Provider of the venue database; as defined by the sender. Currently, only "foursquare" and "gplaces" (Google Places) need to be supported
  string? provider;

  /// Identifier of the venue in the provider database; as defined by the sender
  string? id;

  /// Type of the venue in the provider database; as defined by the sender
  string? type;

  Venue({
    super.extra,
    super.client_id,
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
    if (map['location'] != null) {
      location = TdApiMap.fromMap(map['location']) as Location;
    }
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
