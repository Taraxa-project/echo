import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';

class MessageReplyInfo extends TdObject {
  String get tdType => 'messageReplyInfo';

  string? extra;
  int? client_id;
  int32? reply_count;
  vector<MessageSender>? recent_replier_ids;
  int53? last_read_inbox_message_id;
  int53? last_read_outbox_message_id;
  int53? last_message_id;

  MessageReplyInfo({
    this.extra,
    this.client_id,
    this.reply_count,
    this.recent_replier_ids,
    this.last_read_inbox_message_id,
    this.last_read_outbox_message_id,
    this.last_message_id,
  });

  MessageReplyInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    reply_count = map['reply_count'];
    if (map['recent_replier_ids']) {
      recent_replier_ids = [];
      for (var someValue in map['recent_replier_ids']) {
        recent_replier_ids?.add(TdApiMap.fromMap(someValue) as MessageSender);
      }
    }
    last_read_inbox_message_id = map['last_read_inbox_message_id'];
    last_read_outbox_message_id = map['last_read_outbox_message_id'];
    last_message_id = map['last_message_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'reply_count': reply_count?.toMap(skipNulls: skipNulls),
      'recent_replier_ids': recent_replier_ids?.toMap(skipNulls: skipNulls),
      'last_read_inbox_message_id': last_read_inbox_message_id?.toMap(skipNulls: skipNulls),
      'last_read_outbox_message_id': last_read_outbox_message_id?.toMap(skipNulls: skipNulls),
      'last_message_id': last_message_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
