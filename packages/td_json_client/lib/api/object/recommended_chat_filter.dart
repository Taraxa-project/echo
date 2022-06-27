import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_filter.dart';

class RecommendedChatFilter extends TdObject {
  String get tdType => 'recommendedChatFilter';

  string? extra;
  int? client_id;
  ChatFilter? filter;
  string? description;

  RecommendedChatFilter({
    this.extra,
    this.client_id,
    this.filter,
    this.description,
  });

  RecommendedChatFilter.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    filter = TdApiMap.fromMap(map['filter']) as ChatFilter;
    description = map['description'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'filter': filter?.toMap(skipNulls: skipNulls),
      'description': description?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}