import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_scheduling_state.dart';


/// Options to be used when a message is sent
class MessageSendOptions extends TdObject {
  String get tdType => 'messageSendOptions';


  /// Pass true to disable notification for the message
  Bool? disable_notification;

  /// Pass true if the message is sent from the background
  Bool? from_background;

  /// Pass true if the content of the message must be protected from forwarding and saving; for bots only
  Bool? protect_content;

  /// Message scheduling state; pass null to send message immediately. Messages sent to a secret chat, live location messages and self-destructing messages can't be scheduled
  MessageSchedulingState? scheduling_state;

  MessageSendOptions({
    super.extra,
    super.client_id,
    this.disable_notification,
    this.from_background,
    this.protect_content,
    this.scheduling_state,
  });

  MessageSendOptions.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    disable_notification = map['disable_notification'];
    from_background = map['from_background'];
    protect_content = map['protect_content'];
    if (map['scheduling_state'] != null) {
      scheduling_state = TdApiMap.fromMap(map['scheduling_state']) as MessageSchedulingState;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'disable_notification': disable_notification?.toMap(skipNulls: skipNulls),
      'from_background': from_background?.toMap(skipNulls: skipNulls),
      'protect_content': protect_content?.toMap(skipNulls: skipNulls),
      'scheduling_state': scheduling_state?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
