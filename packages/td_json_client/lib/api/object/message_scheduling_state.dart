import 'package:td_json_client/api/base.dart';

/// Contains information about the time when a scheduled message will be sent
abstract class MessageSchedulingState extends TdObject {}


/// The message will be sent at the specified date 
class MessageSchedulingStateSendAtDate extends MessageSchedulingState {
  String get tdType => 'messageSchedulingStateSendAtDate';

  String? extra;
  int? client_id;

  /// Date the message will be sent. The date must be within 367 days in the future
  int32? send_date;

  MessageSchedulingStateSendAtDate({
    this.extra,
    this.client_id,
    this.send_date,
  });

  MessageSchedulingStateSendAtDate.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    send_date = map['send_date'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'send_date': send_date?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The message will be sent when the peer will be online. Applicable to private chats only and when the exact online status of the peer is known
class MessageSchedulingStateSendWhenOnline extends MessageSchedulingState {
  String get tdType => 'messageSchedulingStateSendWhenOnline';

  String? extra;
  int? client_id;

  MessageSchedulingStateSendWhenOnline({
    this.extra,
    this.client_id,
  });

  MessageSchedulingStateSendWhenOnline.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
