import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/background_type.dart';

/// Constructs a persistent HTTP URL for a background
class GetBackgroundUrl extends TdFunction {
  String get tdType => 'getBackgroundUrl';
  String get tdReturnType => 'HttpUrl';

  /// Background name
  string? name;

  /// Background type
  BackgroundType? type;

  GetBackgroundUrl({
    super.extra,
    super.client_id,
    this.name,
    this.type,
  });

  GetBackgroundUrl.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    name = map['name'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as BackgroundType;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
