import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/group_call_stream.dart';


/// Represents a list of group call streams 
class GroupCallStreams extends TdObject {
  String get tdType => 'groupCallStreams';

  String? extra;
  int? client_id;

  /// A list of group call streams
  vector<GroupCallStream>? streams;

  GroupCallStreams({
    this.extra,
    this.client_id,
    this.streams,
  });

  GroupCallStreams.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['streams']) {
      streams = [];
      for (var someValue in map['streams']) {
        streams?.add(TdApiMap.fromMap(someValue) as GroupCallStream);
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
