import 'package:td_json_client/api/base.dart';

class Chats extends TdObject {
  String get tdType => 'chats';

  string? extra;
  int? client_id;
  int32? total_count;
  vector<int53>? chat_ids;

  Chats({
    this.extra,
    this.client_id,
    this.total_count,
    this.chat_ids,
  });

  Chats.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_count = map['total_count'];
    if (map['chat_ids']) {
      chat_ids = [];
      for (var someValue in map['chat_ids']) {
        chat_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'total_count': total_count?.toMap(skipNulls: skipNulls),
      'chat_ids': chat_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
