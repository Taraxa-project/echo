import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/location.dart';


/// Changes the location of the current user. Needs to be called if GetOption("is_location_visible") is true and location changes for more than 1 kilometer 
class SetLocation extends TdFunction {
  String get tdType => 'setLocation';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// The new location of the user
  Location? location;

  SetLocation({
    this.extra,
    this.client_id,
    this.location,
  });

  SetLocation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    location = TdApiMap.fromMap(map['location']) as Location;
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
