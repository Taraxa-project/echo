import 'package:td_json_client/api/base.dart';


/// Represents a date range 
class DateRange extends TdObject {
  String get tdType => 'dateRange';


  /// Point in time (Unix timestamp) at which the date range begins 
  int32? start_date;

  /// Point in time (Unix timestamp) at which the date range ends
  int32? end_date;

  DateRange({
    super.extra,
    super.client_id,
    this.start_date,
    this.end_date,
  });

  DateRange.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    start_date = map['start_date'];
    end_date = map['end_date'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'start_date': start_date?.toMap(skipNulls: skipNulls),
      'end_date': end_date?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
