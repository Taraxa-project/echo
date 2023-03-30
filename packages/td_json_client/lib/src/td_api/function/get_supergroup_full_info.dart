import 'package:td_json_client/src/td_api/td.dart';

/// Returns full information about a supergroup or a channel by its identifier, cached for up to 1 minute
class GetSupergroupFullInfo extends TdFunction {
  String get tdType => 'getSupergroupFullInfo';
  String get tdReturnType => 'SupergroupFullInfo';

  /// Supergroup or channel identifier
  int53? supergroup_id;

  GetSupergroupFullInfo({
    super.extra,
    super.client_id,
    this.supergroup_id,
  });

  GetSupergroupFullInfo.fromMap(Map<String, dynamic> map) {
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
