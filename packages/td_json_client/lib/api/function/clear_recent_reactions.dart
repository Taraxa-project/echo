import 'package:td_json_client/api/base.dart';


/// Clears the list of recently used reactions
class ClearRecentReactions extends TdFunction {
  String get tdType => 'clearRecentReactions';
  String get tdReturnType => 'Ok';


  ClearRecentReactions({
    super.extra,
    super.client_id,
  });

  ClearRecentReactions.fromMap(Map<String, dynamic> map) {
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
