import 'package:td_json_client/api/base.dart';


/// An object of this type is returned on a successful function call for certain functions
class Ok extends TdObject {
  String get tdType => 'ok';


  Ok({
    super.extra,
    super.client_id,
  });

  Ok.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
