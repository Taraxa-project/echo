import 'package:td_json_client/src/td_api/td.dart';

/// Contains a list of hashtags
class Hashtags extends TdObject {
  String get tdType => 'hashtags';

  /// A list of hashtags
  vector<string>? hashtags;

  Hashtags({
    super.extra,
    super.client_id,
    this.hashtags,
  });

  Hashtags.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['hashtags'] != null) {
      hashtags = [];
      for (var someValue in map['hashtags']) {
        hashtags?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'hashtags': hashtags?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
