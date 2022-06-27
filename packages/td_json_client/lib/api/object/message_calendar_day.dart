import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message.dart';

class MessageCalendarDay extends TdObject {
  String get tdType => 'messageCalendarDay';

  string? extra;
  int? client_id;
  int32? total_count;
  Message? message;

  MessageCalendarDay({
    this.extra,
    this.client_id,
    this.total_count,
    this.message,
  });

  MessageCalendarDay.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_count = map['total_count'];
    message = TdApiMap.fromMap(map['message']) as Message;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'total_count': total_count?.toMap(skipNulls: skipNulls),
      'message': message?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
