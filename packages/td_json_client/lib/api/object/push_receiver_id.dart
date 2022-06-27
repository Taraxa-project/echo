import 'package:td_json_client/api/base.dart';

class PushReceiverId extends TdObject {
  String get tdType => 'pushReceiverId';

  String? extra;
  int? client_id;
  int64? id;

  PushReceiverId({
    this.extra,
    this.client_id,
    this.id,
  });

  PushReceiverId.fromMap(Map<String, dynamic> map) {
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
