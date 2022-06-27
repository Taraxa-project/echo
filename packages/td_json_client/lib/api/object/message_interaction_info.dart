import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_reply_info.dart';
import 'package:td_json_client/api/object/message_reaction.dart';

class MessageInteractionInfo extends TdObject {
  String get tdType => 'messageInteractionInfo';

  String? extra;
  int? client_id;
  int32? view_count;
  int32? forward_count;
  MessageReplyInfo? reply_info;
  vector<MessageReaction>? reactions;

  MessageInteractionInfo({
    this.extra,
    this.client_id,
    this.view_count,
    this.forward_count,
    this.reply_info,
    this.reactions,
  });

  MessageInteractionInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    view_count = map['view_count'];
    forward_count = map['forward_count'];
    reply_info = TdApiMap.fromMap(map['reply_info']) as MessageReplyInfo;
    if (map['reactions']) {
      reactions = [];
      for (var someValue in map['reactions']) {
        reactions?.add(TdApiMap.fromMap(someValue) as MessageReaction);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'view_count': view_count?.toMap(skipNulls: skipNulls),
      'forward_count': forward_count?.toMap(skipNulls: skipNulls),
      'reply_info': reply_info?.toMap(skipNulls: skipNulls),
      'reactions': reactions?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
