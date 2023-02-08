import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_filter.dart';

/// Creates new chat filter. Returns information about the created chat filter. There can be up to getOption("chat_filter_count_max") chat filters, but the limit can be increased with Telegram Premium
class CreateChatFilter extends TdFunction {
  String get tdType => 'createChatFilter';
  String get tdReturnType => 'ChatFilterInfo';

  /// Chat filter
  ChatFilter? filter;

  CreateChatFilter({
    super.extra,
    super.client_id,
    this.filter,
  });

  CreateChatFilter.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['filter'] != null) {
      filter = TdApiMap.fromMap(map['filter']) as ChatFilter;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'filter': filter?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
