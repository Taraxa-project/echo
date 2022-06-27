import 'package:td_json_client/api/base.dart';

class ReorderChatFilters extends TdFunction {
  String get tdType => 'reorderChatFilters';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  vector<int32>? chat_filter_ids;

  ReorderChatFilters({
    this.extra,
    this.client_id,
    this.chat_filter_ids,
  });

  ReorderChatFilters.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['chat_filter_ids']) {
      chat_filter_ids = [];
      for (var someValue in map['chat_filter_ids']) {
        chat_filter_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_filter_ids': chat_filter_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
