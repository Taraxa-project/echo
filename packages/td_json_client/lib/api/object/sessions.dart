import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/session.dart';


/// Contains a list of sessions 
class Sessions extends TdObject {
  String get tdType => 'sessions';

  String? extra;
  int? client_id;

  /// List of sessions 
  vector<Session>? sessions;

  /// Number of days of inactivity before sessions will automatically be terminated; 1-366 days
  int32? inactive_session_ttl_days;

  Sessions({
    this.extra,
    this.client_id,
    this.sessions,
    this.inactive_session_ttl_days,
  });

  Sessions.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sessions']) {
      sessions = [];
      for (var someValue in map['sessions']) {
        sessions?.add(TdApiMap.fromMap(someValue) as Session);
      }
    }
    inactive_session_ttl_days = map['inactive_session_ttl_days'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sessions': sessions?.toMap(skipNulls: skipNulls),
      'inactive_session_ttl_days': inactive_session_ttl_days?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
