import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';

class VideoChat extends TdObject {
  String get tdType => 'videoChat';

  string? extra;
  int? client_id;
  int32? group_call_id;
  Bool? has_participants;
  MessageSender? default_participant_id;

  VideoChat({
    this.extra,
    this.client_id,
    this.group_call_id,
    this.has_participants,
    this.default_participant_id,
  });

  VideoChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    group_call_id = map['group_call_id'];
    has_participants = map['has_participants'];
    default_participant_id = TdApiMap.fromMap(map['default_participant_id']) as MessageSender;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'group_call_id': group_call_id?.toMap(skipNulls: skipNulls),
      'has_participants': has_participants?.toMap(skipNulls: skipNulls),
      'default_participant_id': default_participant_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
