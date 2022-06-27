import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';

class MessageSenders extends TdObject {
  String get tdType => 'messageSenders';

  string? extra;
  int? client_id;
  int32? total_count;
  vector<MessageSender>? senders;

  MessageSenders({
    this.extra,
    this.client_id,
    this.total_count,
    this.senders,
  });

  MessageSenders.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_count = map['total_count'];
    if (map['senders']) {
      senders = [];
      for (var someValue in map['senders']) {
        senders?.add(TdApiMap.fromMap(someValue) as MessageSender);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'total_count': total_count?.toMap(skipNulls: skipNulls),
      'senders': senders?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}