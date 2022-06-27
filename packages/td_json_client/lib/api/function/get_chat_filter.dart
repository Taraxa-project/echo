import 'package:td_json_client/api/base.dart';

class GetChatFilter extends TdFunction {
  String get tdType => 'getChatFilter';
  String get tdReturnType => 'ChatFilter';

  String? extra;
  int? client_id;
  int32? chat_filter_id;

  GetChatFilter({
    this.extra,
    this.client_id,
    this.chat_filter_id,
  });

  GetChatFilter.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_filter_id = map['chat_filter_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_filter_id': chat_filter_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
