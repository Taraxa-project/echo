import 'package:td_json_client/src/td_api/td.dart';

/// Returns up to 20 recently used inline bots in the order of their last usage
class GetRecentInlineBots extends TdFunction {
  String get tdType => 'getRecentInlineBots';
  String get tdReturnType => 'Users';

  GetRecentInlineBots({
    super.extra,
    super.client_id,
  });

  GetRecentInlineBots.fromMap(Map<String, dynamic> map) {
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
