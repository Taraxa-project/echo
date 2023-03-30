import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/message_scheduling_state.dart';

/// Edits the time when a scheduled message will be sent. Scheduling state of all messages in the same album or forwarded together with the message will be also changed
class EditMessageSchedulingState extends TdFunction {
  String get tdType => 'editMessageSchedulingState';
  String get tdReturnType => 'Ok';

  /// The chat the message belongs to
  int53? chat_id;

  /// Identifier of the message
  int53? message_id;

  /// The new message scheduling state; pass null to send the message immediately
  MessageSchedulingState? scheduling_state;

  EditMessageSchedulingState({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_id,
    this.scheduling_state,
  });

  EditMessageSchedulingState.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    if (map['scheduling_state'] != null) {
      scheduling_state =
          TdApiMap.fromMap(map['scheduling_state']) as MessageSchedulingState;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'scheduling_state': scheduling_state?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
