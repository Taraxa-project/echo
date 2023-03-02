import 'package:td_json_client/api/base.dart';


/// Represents a list of chats 
class Chats extends TdObject {
  String get tdType => 'chats';


  /// Approximate total number of chats found 
  int32? total_count;

  /// List of chat identifiers
  vector<int53>? chat_ids;

  Chats({
    super.extra,
    super.client_id,
    this.total_count,
    this.chat_ids,
  });

  Chats.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_count = map['total_count'];
    if (map['chat_ids'] != null) {
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
