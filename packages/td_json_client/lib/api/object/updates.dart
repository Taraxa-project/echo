import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/update.dart';

class Updates extends TdObject {
  String get tdType => 'updates';

  string? extra;
  int? client_id;
  vector<Update>? updates;

  Updates({
    this.extra,
    this.client_id,
    this.updates,
  });

  Updates.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['updates']) {
      updates = [];
      for (var someValue in map['updates']) {
        updates?.add(TdApiMap.fromMap(someValue) as Update);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'updates': updates?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
