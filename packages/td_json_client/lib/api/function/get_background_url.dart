import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/background_type.dart';

class GetBackgroundUrl extends TdFunction {
  String get tdType => 'getBackgroundUrl';
  String get tdReturnType => 'HttpUrl';

  String? extra;
  int? client_id;
  string? name;
  BackgroundType? type;

  GetBackgroundUrl({
    this.extra,
    this.client_id,
    this.name,
    this.type,
  });

  GetBackgroundUrl.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    name = map['name'];
    type = TdApiMap.fromMap(map['type']) as BackgroundType;
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
