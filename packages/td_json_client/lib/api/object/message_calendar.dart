import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_calendar_day.dart';

class MessageCalendar extends TdObject {
  String get tdType => 'messageCalendar';

  string? extra;
  int? client_id;
  int32? total_count;
  vector<MessageCalendarDay>? days;

  MessageCalendar({
    this.extra,
    this.client_id,
    this.total_count,
    this.days,
  });

  MessageCalendar.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_count = map['total_count'];
    if (map['days']) {
      days = [];
      for (var someValue in map['days']) {
        days?.add(TdApiMap.fromMap(someValue) as MessageCalendarDay);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'total_count': total_count?.toMap(skipNulls: skipNulls),
      'days': days?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
