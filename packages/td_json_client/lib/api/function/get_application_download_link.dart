import 'package:td_json_client/api/base.dart';


/// Returns the link for downloading official Telegram application to be used when the current user invites friends to Telegram
class GetApplicationDownloadLink extends TdFunction {
  String get tdType => 'getApplicationDownloadLink';
  String get tdReturnType => 'HttpUrl';

  String? extra;
  int? client_id;

  GetApplicationDownloadLink({
    this.extra,
    this.client_id,
  });

  GetApplicationDownloadLink.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
