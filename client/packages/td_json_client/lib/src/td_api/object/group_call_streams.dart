import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/group_call_stream.dart';

/// Represents a list of group call streams
class GroupCallStreams extends TdObject {
  String get tdType => 'groupCallStreams';

  /// A list of group call streams
  vector<GroupCallStream>? streams;

  GroupCallStreams({
    super.extra,
    super.client_id,
    this.streams,
  });

  GroupCallStreams.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['streams'] != null) {
      streams = [];
      for (var someValue in map['streams']) {
        if (someValue != null) {
          streams?.add(TdApiMap.fromMap(someValue) as GroupCallStream);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'streams': streams?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
