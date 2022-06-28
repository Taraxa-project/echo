import 'package:td_json_client/api/base.dart';


/// Returns information about an action to be done when the current user clicks an external link. Don't use this method for links from secret chats if web page preview is disabled in secret chats 
class GetExternalLinkInfo extends TdFunction {
  String get tdType => 'getExternalLinkInfo';
  String get tdReturnType => 'LoginUrlInfo';

  String? extra;
  int? client_id;

  /// The link
  string? link;

  GetExternalLinkInfo({
    this.extra,
    this.client_id,
    this.link,
  });

  GetExternalLinkInfo.fromMap(Map<String, dynamic> map) {
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
