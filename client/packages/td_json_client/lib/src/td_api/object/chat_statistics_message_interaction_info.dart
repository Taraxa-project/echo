import 'package:td_json_client/src/td_api/td.dart';

/// Contains statistics about interactions with a message
class ChatStatisticsMessageInteractionInfo extends TdObject {
  String get tdType => 'chatStatisticsMessageInteractionInfo';

  /// Message identifier
  int53? message_id;

  /// Number of times the message was viewed
  int32? view_count;

  /// Number of times the message was forwarded
  int32? forward_count;

  ChatStatisticsMessageInteractionInfo({
    super.extra,
    super.client_id,
    this.message_id,
    this.view_count,
    this.forward_count,
  });

  ChatStatisticsMessageInteractionInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    message_id = map['message_id'];
    view_count = map['view_count'];
    forward_count = map['forward_count'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'view_count': view_count?.toMap(skipNulls: skipNulls),
      'forward_count': forward_count?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
