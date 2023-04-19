import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_filter.dart';

/// Edits existing chat filter. Returns information about the edited chat filter
class EditChatFilter extends TdFunction {
  String get tdType => 'editChatFilter';
  String get tdReturnType => 'ChatFilterInfo';

  /// Chat filter identifier
  int32? chat_filter_id;

  /// The edited chat filter
  ChatFilter? filter;

  EditChatFilter({
    super.extra,
    super.client_id,
    this.chat_filter_id,
    this.filter,
  });

  EditChatFilter.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_filter_id = map['chat_filter_id'];
    if (map['filter'] != null) {
      filter = TdApiMap.fromMap(map['filter']) as ChatFilter;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_filter_id': chat_filter_id?.toMap(skipNulls: skipNulls),
      'filter': filter?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}