import 'package:td_json_client/src/td_api/td.dart';

/// Contains the group call identifier
class GroupCallId extends TdObject {
  String get tdType => 'groupCallId';

  /// Group call identifier
  int32? id;

  GroupCallId({
    super.extra,
    super.client_id,
    this.id,
  });

  GroupCallId.fromMap(Map<String, dynamic> map) {
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
