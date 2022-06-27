import 'package:td_json_client/api/base.dart';

class GetChatMessageByDate extends TdFunction {
  String get tdType => 'getChatMessageByDate';
  String get tdReturnType => 'Message';

  String? extra;
  int? client_id;
  int53? chat_id;
  int32? date;

  GetChatMessageByDate({
    this.extra,
    this.client_id,
    this.chat_id,
    this.date,
  });

  GetChatMessageByDate.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    date = map['date'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'date': date?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
