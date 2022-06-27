import 'package:td_json_client/api/base.dart';

abstract class MessageSchedulingState extends TdObject {}

class MessageSchedulingStateSendAtDate extends MessageSchedulingState {
  String get tdType => 'messageSchedulingStateSendAtDate';

  string? extra;
  int? client_id;
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
class MessageSchedulingStateSendWhenOnline extends MessageSchedulingState {
  String get tdType => 'messageSchedulingStateSendWhenOnline';

  string? extra;
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
