import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/internal_link_type.dart';

/// Returns an HTTPS or a tg: link with the given type. Can be called before authorization
class GetInternalLink extends TdFunction {
  String get tdType => 'getInternalLink';
  String get tdReturnType => 'HttpUrl';

  /// Expected type of the link
  InternalLinkType? type;

  /// Pass true to create an HTTPS link (only available for some link types); pass false to create a tg: link
  Bool? is_http;

  GetInternalLink({
    super.extra,
    super.client_id,
    this.type,
    this.is_http,
  });

  GetInternalLink.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as InternalLinkType;
    }
    is_http = map['is_http'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'is_http': is_http?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
