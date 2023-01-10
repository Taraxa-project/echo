import 'package:td_json_client/api/base.dart';


/// Contains the call identifier 
class CallId extends TdObject {
  String get tdType => 'callId';


  /// Call identifier
  int32? id;

  CallId({
    super.extra,
    super.client_id,
    this.id,
  });

  CallId.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
