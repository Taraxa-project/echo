import 'package:td_json_client/api/base.dart';

class GetDeepLinkInfo extends TdFunction {
  String get tdType => 'getDeepLinkInfo';
  String get tdReturnType => 'DeepLinkInfo';

  string? extra;
  int? client_id;
  string? link;

  GetDeepLinkInfo({
    this.extra,
    this.client_id,
    this.link,
  });

  GetDeepLinkInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    link = map['link'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'link': link?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
