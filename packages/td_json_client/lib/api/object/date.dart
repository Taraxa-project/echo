import 'package:td_json_client/api/base.dart';


/// Represents a date according to the Gregorian calendar 
class Date extends TdObject {
  String get tdType => 'date';

  String? extra;
  int? client_id;

  /// Day of the month; 1-31 
  int32? day;

  /// Month; 1-12 
  int32? month;

  /// Year; 1-9999
  int32? year;

  Date({
    this.extra,
    this.client_id,
    this.day,
    this.month,
    this.year,
  });

  Date.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    day = map['day'];
    month = map['month'];
    year = map['year'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'day': day?.toMap(skipNulls: skipNulls),
      'month': month?.toMap(skipNulls: skipNulls),
      'year': year?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
