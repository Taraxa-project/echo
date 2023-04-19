import 'package:td_json_client/src/td_api/td.dart';

/// Contains a list of available TDLib internal log tags
class LogTags extends TdObject {
  String get tdType => 'logTags';

  /// List of log tags
  vector<string>? tags;

  LogTags({
    super.extra,
    super.client_id,
    this.tags,
  });

  LogTags.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['tags'] != null) {
      tags = [];
      for (var someValue in map['tags']) {
        tags?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'tags': tags?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
