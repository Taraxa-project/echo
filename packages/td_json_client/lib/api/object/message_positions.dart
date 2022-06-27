import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_position.dart';

class MessagePositions extends TdObject {
  String get tdType => 'messagePositions';

  string? extra;
  int? client_id;
  int32? total_count;
  vector<MessagePosition>? positions;

  MessagePositions({
    this.extra,
    this.client_id,
    this.total_count,
    this.positions,
  });

  MessagePositions.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_count = map['total_count'];
    if (map['positions']) {
      positions = [];
      for (var someValue in map['positions']) {
        positions?.add(TdApiMap.fromMap(someValue) as MessagePosition);
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
