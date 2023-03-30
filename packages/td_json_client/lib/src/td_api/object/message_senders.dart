import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/message_sender.dart';

/// Represents a list of message senders
class MessageSenders extends TdObject {
  String get tdType => 'messageSenders';

  /// Approximate total number of messages senders found
  int32? total_count;

  /// List of message senders
  vector<MessageSender>? senders;

  MessageSenders({
    super.extra,
    super.client_id,
    this.total_count,
    this.senders,
  });

  MessageSenders.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_count = map['total_count'];
    if (map['senders'] != null) {
      senders = [];
      for (var someValue in map['senders']) {
        if (someValue != null) {
          senders?.add(TdApiMap.fromMap(someValue) as MessageSender);
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
      'senders': senders?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
