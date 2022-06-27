import 'package:td_json_client/api/base.dart';

class CreateVideoChat extends TdFunction {
  String get tdType => 'createVideoChat';
  String get tdReturnType => 'GroupCallId';

  String? extra;
  int? client_id;
  int53? chat_id;
  string? title;
  int32? start_date;
  Bool? is_rtmp_stream;

  CreateVideoChat({
    this.extra,
    this.client_id,
    this.chat_id,
    this.title,
    this.start_date,
    this.is_rtmp_stream,
  });

  CreateVideoChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    title = map['title'];
    start_date = map['start_date'];
    is_rtmp_stream = map['is_rtmp_stream'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'start_date': start_date?.toMap(skipNulls: skipNulls),
      'is_rtmp_stream': is_rtmp_stream?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
