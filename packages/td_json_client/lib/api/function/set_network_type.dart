import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/network_type.dart';

class SetNetworkType extends TdFunction {
  String get tdType => 'setNetworkType';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  NetworkType? type;

  SetNetworkType({
    this.extra,
    this.client_id,
    this.type,
  });

  SetNetworkType.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    type = TdApiMap.fromMap(map['type']) as NetworkType;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}