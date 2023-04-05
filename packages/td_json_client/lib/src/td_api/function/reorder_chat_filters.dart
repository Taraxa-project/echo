import 'package:td_json_client/src/td_api/td.dart';

/// Changes the order of chat filters
class ReorderChatFilters extends TdFunction {
  String get tdType => 'reorderChatFilters';
  String get tdReturnType => 'Ok';

  /// Identifiers of chat filters in the new correct order
  vector<int32>? chat_filter_ids;

  /// Position of the main chat list among chat filters, 0-based. Can be non-zero only for Premium users
  int32? main_chat_list_position;

  ReorderChatFilters({
    super.extra,
    super.client_id,
    this.chat_filter_ids,
    this.main_chat_list_position,
  });

  ReorderChatFilters.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['chat_filter_ids'] != null) {
      chat_filter_ids = [];
      for (var someValue in map['chat_filter_ids']) {
        chat_filter_ids?.add(someValue);
      }
    }
    main_chat_list_position = map['main_chat_list_position'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_filter_ids': chat_filter_ids?.toMap(skipNulls: skipNulls),
      'main_chat_list_position': main_chat_list_position?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
