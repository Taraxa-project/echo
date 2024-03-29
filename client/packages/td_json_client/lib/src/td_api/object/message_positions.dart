import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/message_position.dart';

/// Contains a list of message positions
class MessagePositions extends TdObject {
  String get tdType => 'messagePositions';

  /// Total number of messages found
  int32? total_count;

  /// List of message positions
  vector<MessagePosition>? positions;

  MessagePositions({
    super.extra,
    super.client_id,
    this.total_count,
    this.positions,
  });

  MessagePositions.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_count = map['total_count'];
    if (map['positions'] != null) {
      positions = [];
      for (var someValue in map['positions']) {
        if (someValue != null) {
          positions?.add(TdApiMap.fromMap(someValue) as MessagePosition);
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
      'positions': positions?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
