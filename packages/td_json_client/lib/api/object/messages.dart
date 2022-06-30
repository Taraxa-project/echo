import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message.dart';


/// Contains a list of messages 
class Messages extends TdObject {
  String get tdType => 'messages';


  /// Approximate total count of messages found 
  int32? total_count;

  /// List of messages; messages may be null
  vector<Message>? messages;

  Messages({
    super.extra,
    super.client_id,
    this.total_count,
    this.messages,
  });

  Messages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_count = map['total_count'];
    if (map['messages'] != null) {
      messages = [];
      for (var someValue in map['messages']) {
        if (someValue != null) {
          messages?.add(TdApiMap.fromMap(someValue) as Message);
        }
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
