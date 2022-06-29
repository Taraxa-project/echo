import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/location.dart';


/// Represents a location to which a chat is connected 
class ChatLocation extends TdObject {
  String get tdType => 'chatLocation';

  String? extra;
  int? client_id;

  /// The location 
  Location? location;

  /// Location address; 1-64 characters, as defined by the chat owner
  string? address;

  ChatLocation({
    this.extra,
    this.client_id,
    this.location,
    this.address,
  });

  ChatLocation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['location'] != null) {
      location = TdApiMap.fromMap(map['location']) as Location;
    }
    address = map['address'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'location': location?.toMap(skipNulls: skipNulls),
      'address': address?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
