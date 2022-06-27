import 'package:td_json_client/api/base.dart';

class DisconnectWebsite extends TdFunction {
  String get tdType => 'disconnectWebsite';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int64? website_id;

  DisconnectWebsite({
    this.extra,
    this.client_id,
    this.website_id,
  });

  DisconnectWebsite.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    website_id = map['website_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'website_id': website_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
