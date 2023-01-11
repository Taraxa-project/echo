import 'package:td_json_client/api/base.dart';


/// Contains an HTTPS URL, which can be used to get information about a user 
class UserLink extends TdObject {
  String get tdType => 'userLink';


  /// The URL 
  string? url;

  /// Left time for which the link is valid, in seconds; 0 if the link is a public username link
  int32? expires_in;

  UserLink({
    super.extra,
    super.client_id,
    this.url,
    this.expires_in,
  });

  UserLink.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    url = map['url'];
    expires_in = map['expires_in'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
      'expires_in': expires_in?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
