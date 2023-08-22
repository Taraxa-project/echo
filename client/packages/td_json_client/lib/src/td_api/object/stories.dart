import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/story.dart';

/// Represents a list of stories
class Stories extends TdObject {
  String get tdType => 'stories';

  /// Approximate total number of stories found
  int32? total_count;

  /// The list of stories
  vector<Story>? stories;

  Stories({
    super.extra,
    super.client_id,
    this.total_count,
    this.stories,
  });

  Stories.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_count = map['total_count'];
    if (map['stories'] != null) {
      stories = [];
      for (var someValue in map['stories']) {
        if (someValue != null) {
          stories?.add(TdApiMap.fromMap(someValue) as Story);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'total_count': total_count?.toMap(skipNulls: skipNulls),
      'stories': stories?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
