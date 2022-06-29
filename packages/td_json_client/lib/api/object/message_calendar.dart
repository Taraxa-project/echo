import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_calendar_day.dart';


/// Contains information about found messages, split by days according to the option "utc_time_offset" 
class MessageCalendar extends TdObject {
  String get tdType => 'messageCalendar';

  String? extra;
  int? client_id;

  /// Total number of found messages 
  int32? total_count;

  /// Information about messages sent
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
    if (map['days'] != null) {
      days = [];
      for (var someValue in map['days']) {
        if (someValue != null) {
          days?.add(TdApiMap.fromMap(someValue) as MessageCalendarDay);
        }
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
