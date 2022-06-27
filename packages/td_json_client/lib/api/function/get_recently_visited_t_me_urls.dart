import 'package:td_json_client/api/base.dart';

class GetRecentlyVisitedTMeUrls extends TdFunction {
  String get tdType => 'getRecentlyVisitedTMeUrls';
  String get tdReturnType => 'TMeUrls';

  String? extra;
  int? client_id;
  string? referrer;

  GetRecentlyVisitedTMeUrls({
    this.extra,
    this.client_id,
    this.referrer,
  });

  GetRecentlyVisitedTMeUrls.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    referrer = map['referrer'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'referrer': referrer?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
