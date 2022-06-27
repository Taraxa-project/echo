import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_scheduling_state.dart';

class MessageSendOptions extends TdObject {
  String get tdType => 'messageSendOptions';

  string? extra;
  int? client_id;
  Bool? disable_notification;
  Bool? from_background;
  MessageSchedulingState? scheduling_state;

  MessageSendOptions({
    this.extra,
    this.client_id,
    this.disable_notification,
    this.from_background,
    this.scheduling_state,
  });

  MessageSendOptions.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    disable_notification = map['disable_notification'];
    from_background = map['from_background'];
    scheduling_state = TdApiMap.fromMap(map['scheduling_state']) as MessageSchedulingState;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'disable_notification': disable_notification?.toMap(skipNulls: skipNulls),
      'from_background': from_background?.toMap(skipNulls: skipNulls),
      'scheduling_state': scheduling_state?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
