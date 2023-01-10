import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/location.dart';


/// Returns a list of users and location-based supergroups nearby. The list of users nearby will be updated for 60 seconds after the request by the updates updateUsersNearby. The request must be sent again every 25 seconds with adjusted location to not miss new chats 
class SearchChatsNearby extends TdFunction {
  String get tdType => 'searchChatsNearby';
  String get tdReturnType => 'ChatsNearby';


  /// Current user location
  Location? location;

  SearchChatsNearby({
    super.extra,
    super.client_id,
    this.location,
  });

  SearchChatsNearby.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['location'] != null) {
      location = TdApiMap.fromMap(map['location']) as Location;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'location': location?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
