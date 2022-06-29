import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_filter.dart';


/// Describes a recommended chat filter 
class RecommendedChatFilter extends TdObject {
  String get tdType => 'recommendedChatFilter';

  String? extra;
  int? client_id;

  /// The chat filter 
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
    if (map['filter'] != null) {
      filter = TdApiMap.fromMap(map['filter']) as ChatFilter;
    }
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
