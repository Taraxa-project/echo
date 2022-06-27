import 'package:td_json_client/api/base.dart';

class MessageLink extends TdObject {
  String get tdType => 'messageLink';

  String? extra;
  int? client_id;
  string? link;
  Bool? is_public;

  MessageLink({
    this.extra,
    this.client_id,
    this.link,
    this.is_public,
  });

  MessageLink.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    link = map['link'];
    is_public = map['is_public'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'link': link?.toMap(skipNulls: skipNulls),
      'is_public': is_public?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
