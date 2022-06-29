import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_reply_info.dart';
import 'package:td_json_client/api/object/message_reaction.dart';


/// Contains information about interactions with a message
class MessageInteractionInfo extends TdObject {
  String get tdType => 'messageInteractionInfo';

  String? extra;
  int? client_id;

  /// Number of times the message was viewed
  int32? view_count;

  /// Number of times the message was forwarded
  int32? forward_count;

  /// Information about direct or indirect replies to the message; may be null. Currently, available only in channels with a discussion supergroup and discussion supergroups for messages, which are not replies itself
  MessageReplyInfo? reply_info;

  /// The list of reactions added to the message
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
    if (map['reply_info'] != null) {
      reply_info = TdApiMap.fromMap(map['reply_info']) as MessageReplyInfo;
    }
    if (map['reactions'] != null) {
      reactions = [];
      for (var someValue in map['reactions']) {
        if (someValue != null) {
          reactions?.add(TdApiMap.fromMap(someValue) as MessageReaction);
        }
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
