import 'package:td_json_client/api/base.dart';

class GetExternalLink extends TdFunction {
  String get tdType => 'getExternalLink';
  String get tdReturnType => 'HttpUrl';

  String? extra;
  int? client_id;
  string? link;
  Bool? allow_write_access;

  GetExternalLink({
    this.extra,
    this.client_id,
    this.link,
    this.allow_write_access,
  });

  GetExternalLink.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    link = map['link'];
    allow_write_access = map['allow_write_access'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'link': link?.toMap(skipNulls: skipNulls),
      'allow_write_access': allow_write_access?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
