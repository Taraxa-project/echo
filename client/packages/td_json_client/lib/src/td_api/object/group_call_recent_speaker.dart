import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/message_sender.dart';

/// Describes a recently speaking participant in a group call
class GroupCallRecentSpeaker extends TdObject {
  String get tdType => 'groupCallRecentSpeaker';

  /// Group call participant identifier
  MessageSender? participant_id;

  /// True, is the user has spoken recently
  Bool? is_speaking;

  GroupCallRecentSpeaker({
    super.extra,
    super.client_id,
    this.participant_id,
    this.is_speaking,
  });

  GroupCallRecentSpeaker.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['participant_id'] != null) {
      participant_id = TdApiMap.fromMap(map['participant_id']) as MessageSender;
    }
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
