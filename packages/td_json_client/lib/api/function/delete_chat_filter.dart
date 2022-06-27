import 'package:td_json_client/api/base.dart';

class DeleteChatFilter extends TdFunction {
  String get tdType => 'deleteChatFilter';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  int32? chat_filter_id;

  DeleteChatFilter({
    this.extra,
    this.client_id,
    this.chat_filter_id,
  });

  DeleteChatFilter.fromMap(Map<String, dynamic> map) {
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
