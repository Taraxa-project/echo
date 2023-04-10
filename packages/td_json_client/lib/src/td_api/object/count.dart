import 'package:td_json_client/src/td_api/td.dart';

/// Contains a counter
class Count extends TdObject {
  String get tdType => 'count';

  /// Count
  int32? count;

  Count({
    super.extra,
    super.client_id,
    this.count,
  });

  Count.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    count = map['count'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'count': count?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
