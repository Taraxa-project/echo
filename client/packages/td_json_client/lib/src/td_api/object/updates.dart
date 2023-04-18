import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/update.dart';

/// Contains a list of updates
class Updates extends TdObject {
  String get tdType => 'updates';

  /// List of updates
  vector<Update>? updates;

  Updates({
    super.extra,
    super.client_id,
    this.updates,
  });

  Updates.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['updates'] != null) {
      updates = [];
      for (var someValue in map['updates']) {
        if (someValue != null) {
          updates?.add(TdApiMap.fromMap(someValue) as Update);
        }
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
