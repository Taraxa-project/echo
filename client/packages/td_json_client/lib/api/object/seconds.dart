import 'package:td_json_client/api/base.dart';


/// Contains a value representing a number of seconds 
class Seconds extends TdObject {
  String get tdType => 'seconds';


  /// Number of seconds
  double? seconds;

  Seconds({
    super.extra,
    super.client_id,
    this.seconds,
  });

  Seconds.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    seconds = map['seconds'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'seconds': seconds?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
