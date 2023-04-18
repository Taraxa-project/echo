import 'package:td_json_client/src/td_api/td.dart';

/// Returns an instant view version of a web page if available. Returns a 404 error if the web page has no instant view page
class GetWebPageInstantView extends TdFunction {
  String get tdType => 'getWebPageInstantView';
  String get tdReturnType => 'WebPageInstantView';

  /// The web page URL
  string? url;

  /// Pass true to get full instant view for the web page
  Bool? force_full;

  GetWebPageInstantView({
    super.extra,
    super.client_id,
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
