import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';

class GroupCallRecentSpeaker extends TdObject {
  String get tdType => 'groupCallRecentSpeaker';

  String? extra;
  int? client_id;
  MessageSender? participant_id;
  Bool? is_speaking;

  GroupCallRecentSpeaker({
    this.extra,
    this.client_id,
    this.participant_id,
    this.is_speaking,
  });

  GroupCallRecentSpeaker.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    participant_id = TdApiMap.fromMap(map['participant_id']) as MessageSender;
    is_speaking = map['is_speaking'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'participant_id': participant_id?.toMap(skipNulls: skipNulls),
      'is_speaking': is_speaking?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
