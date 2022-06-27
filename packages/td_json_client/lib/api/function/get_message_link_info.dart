import 'package:td_json_client/api/base.dart';

class GetMessageLinkInfo extends TdFunction {
  String get tdType => 'getMessageLinkInfo';
  String get tdReturnType => 'MessageLinkInfo';

  string? extra;
  int? client_id;
  string? url;

  GetMessageLinkInfo({
    this.extra,
    this.client_id,
    this.url,
  });

  GetMessageLinkInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    url = map['url'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
