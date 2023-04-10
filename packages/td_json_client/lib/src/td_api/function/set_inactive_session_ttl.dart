import 'package:td_json_client/src/td_api/td.dart';

/// Changes the period of inactivity after which sessions will automatically be terminated
class SetInactiveSessionTtl extends TdFunction {
  String get tdType => 'setInactiveSessionTtl';
  String get tdReturnType => 'Ok';

  /// New number of days of inactivity before sessions will be automatically terminated; 1-366 days
  int32? inactive_session_ttl_days;

  SetInactiveSessionTtl({
    super.extra,
    super.client_id,
    this.inactive_session_ttl_days,
  });

  SetInactiveSessionTtl.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    inactive_session_ttl_days = map['inactive_session_ttl_days'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'inactive_session_ttl_days': inactive_session_ttl_days?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
