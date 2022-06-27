import 'package:td_json_client/api/base.dart';

class GetWebPageInstantView extends TdFunction {
  String get tdType => 'getWebPageInstantView';
  String get tdReturnType => 'WebPageInstantView';

  string? extra;
  int? client_id;
  string? url;
  Bool? force_full;

  GetWebPageInstantView({
    this.extra,
    this.client_id,
    this.url,
    this.force_full,
  });

  GetWebPageInstantView.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    url = map['url'];
    force_full = map['force_full'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
      'force_full': force_full?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
