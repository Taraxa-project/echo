import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/network_type.dart';

/// Sets the current network type. Can be called before authorization. Calling this method forces all network connections to reopen, mitigating the delay in switching between different networks,
/// so it must be called whenever the network is changed, even if the network type remains the same. Network type is used to check whether the library can use the network at all and also for collecting detailed network data usage statistics
class SetNetworkType extends TdFunction {
  String get tdType => 'setNetworkType';
  String get tdReturnType => 'Ok';

  /// The new network type; pass null to set network type to networkTypeOther
  NetworkType? type;

  SetNetworkType({
    super.extra,
    super.client_id,
    this.type,
  });

  SetNetworkType.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as NetworkType;
    }
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
