import 'package:td_json_client/src/td_api/td.dart';

/// Returns information about a chat filter by its identifier
class GetChatFilter extends TdFunction {
  String get tdType => 'getChatFilter';
  String get tdReturnType => 'ChatFilter';

  /// Chat filter identifier
  int32? chat_filter_id;

  GetChatFilter({
    super.extra,
    super.client_id,
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
