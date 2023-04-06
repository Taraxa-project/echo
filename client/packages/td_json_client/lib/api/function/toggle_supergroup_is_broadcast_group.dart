import 'package:td_json_client/api/base.dart';


/// Upgrades supergroup to a broadcast group; requires owner privileges in the supergroup 
class ToggleSupergroupIsBroadcastGroup extends TdFunction {
  String get tdType => 'toggleSupergroupIsBroadcastGroup';
  String get tdReturnType => 'Ok';


  /// Identifier of the supergroup
  int53? supergroup_id;

  ToggleSupergroupIsBroadcastGroup({
    super.extra,
    super.client_id,
    this.supergroup_id,
  });

  ToggleSupergroupIsBroadcastGroup.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    supergroup_id = map['supergroup_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'supergroup_id': supergroup_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}