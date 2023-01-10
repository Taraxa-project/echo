import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/recommended_chat_filter.dart';


/// Contains a list of recommended chat filters 
class RecommendedChatFilters extends TdObject {
  String get tdType => 'recommendedChatFilters';


  /// List of recommended chat filters
  vector<RecommendedChatFilter>? chat_filters;

  RecommendedChatFilters({
    super.extra,
    super.client_id,
    this.chat_filters,
  });

  RecommendedChatFilters.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['chat_filters'] != null) {
      chat_filters = [];
      for (var someValue in map['chat_filters']) {
        if (someValue != null) {
          chat_filters?.add(TdApiMap.fromMap(someValue) as RecommendedChatFilter);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_filters': chat_filters?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
