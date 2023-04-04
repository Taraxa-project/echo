import 'package:td_json_client/src/td_api/td.dart';

/// Returns information about the type of an internal link. Returns a 404 error if the link is not internal. Can be called before authorization
class GetInternalLinkType extends TdFunction {
  String get tdType => 'getInternalLinkType';
  String get tdReturnType => 'InternalLinkType';

  /// The link
  string? link;

  GetInternalLinkType({
    super.extra,
    super.client_id,
    this.link,
  });

  GetInternalLinkType.fromMap(Map<String, dynamic> map) {
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