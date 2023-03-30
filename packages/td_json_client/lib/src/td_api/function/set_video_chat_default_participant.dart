import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/message_sender.dart';

/// Changes default participant identifier, on whose behalf a video chat in the chat will be joined
class SetVideoChatDefaultParticipant extends TdFunction {
  String get tdType => 'setVideoChatDefaultParticipant';
  String get tdReturnType => 'Ok';

  /// Chat identifier
  int53? chat_id;

  /// Default group call participant identifier to join the video chats
  MessageSender? default_participant_id;

  SetVideoChatDefaultParticipant({
    super.extra,
    super.client_id,
    this.chat_id,
    this.default_participant_id,
  });

  SetVideoChatDefaultParticipant.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['default_participant_id'] != null) {
      default_participant_id =
          TdApiMap.fromMap(map['default_participant_id']) as MessageSender;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'default_participant_id':
          default_participant_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
