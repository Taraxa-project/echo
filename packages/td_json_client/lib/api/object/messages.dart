import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message.dart';

class Messages extends TdObject {
  String get tdType => 'messages';

  String? extra;
  int? client_id;
  int32? total_count;
  vector<Message>? messages;

  Messages({
    this.extra,
    this.client_id,
    this.total_count,
    this.messages,
  });

  Messages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_count = map['total_count'];
    if (map['messages']) {
      messages = [];
      for (var someValue in map['messages']) {
        messages?.add(TdApiMap.fromMap(someValue) as Message);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'total_count': total_count?.toMap(skipNulls: skipNulls),
      'messages': messages?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
