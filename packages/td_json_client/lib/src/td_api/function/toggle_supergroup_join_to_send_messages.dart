import 'package:td_json_client/src/td_api/td.dart';

/// Toggles whether joining is mandatory to send messages to a discussion supergroup; requires can_restrict_members administrator right
class ToggleSupergroupJoinToSendMessages extends TdFunction {
  String get tdType => 'toggleSupergroupJoinToSendMessages';
  String get tdReturnType => 'Ok';

  /// Identifier of the supergroup
  int53? supergroup_id;

  /// New value of join_to_send_messages
  Bool? join_to_send_messages;

  ToggleSupergroupJoinToSendMessages({
    super.extra,
    super.client_id,
    this.supergroup_id,
    this.join_to_send_messages,
  });

  ToggleSupergroupJoinToSendMessages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    supergroup_id = map['supergroup_id'];
    join_to_send_messages = map['join_to_send_messages'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'supergroup_id': supergroup_id?.toMap(skipNulls: skipNulls),
      'join_to_send_messages':
          join_to_send_messages?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
