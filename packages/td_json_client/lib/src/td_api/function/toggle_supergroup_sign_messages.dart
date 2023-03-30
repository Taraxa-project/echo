import 'package:td_json_client/src/td_api/td.dart';

/// Toggles whether sender signature is added to sent messages in a channel; requires can_change_info administrator right
class ToggleSupergroupSignMessages extends TdFunction {
  String get tdType => 'toggleSupergroupSignMessages';
  String get tdReturnType => 'Ok';

  /// Identifier of the channel
  int53? supergroup_id;

  /// New value of sign_messages
  Bool? sign_messages;

  ToggleSupergroupSignMessages({
    super.extra,
    super.client_id,
    this.supergroup_id,
    this.sign_messages,
  });

  ToggleSupergroupSignMessages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    supergroup_id = map['supergroup_id'];
    sign_messages = map['sign_messages'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'supergroup_id': supergroup_id?.toMap(skipNulls: skipNulls),
      'sign_messages': sign_messages?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
