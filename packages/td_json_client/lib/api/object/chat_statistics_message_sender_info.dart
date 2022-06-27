import 'package:td_json_client/api/base.dart';


/// Contains statistics about messages sent by a user
class ChatStatisticsMessageSenderInfo extends TdObject {
  String get tdType => 'chatStatisticsMessageSenderInfo';

  String? extra;
  int? client_id;

  /// User identifier
  int53? user_id;

  /// Number of sent messages
  int32? sent_message_count;

  /// Average number of characters in sent messages; 0 if unknown
  int32? average_character_count;

  ChatStatisticsMessageSenderInfo({
    this.extra,
    this.client_id,
    this.user_id,
    this.sent_message_count,
    this.average_character_count,
  });

  ChatStatisticsMessageSenderInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    sent_message_count = map['sent_message_count'];
    average_character_count = map['average_character_count'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'sent_message_count': sent_message_count?.toMap(skipNulls: skipNulls),
      'average_character_count': average_character_count?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
