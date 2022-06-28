import 'package:td_json_client/api/base.dart';


/// Returns recommended chat filters for the current user
class GetRecommendedChatFilters extends TdFunction {
  String get tdType => 'getRecommendedChatFilters';
  String get tdReturnType => 'RecommendedChatFilters';

  String? extra;
  int? client_id;

  GetRecommendedChatFilters({
    this.extra,
    this.client_id,
  });

  GetRecommendedChatFilters.fromMap(Map<String, dynamic> map) {
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
