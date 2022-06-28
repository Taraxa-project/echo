import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_join_request.dart';


/// Contains a list of requests to join a chat 
class ChatJoinRequests extends TdObject {
  String get tdType => 'chatJoinRequests';

  String? extra;
  int? client_id;

  /// Approximate total number of requests found 
  int32? total_count;

  /// List of the requests
  vector<ChatJoinRequest>? requests;

  ChatJoinRequests({
    this.extra,
    this.client_id,
    this.total_count,
    this.requests,
  });

  ChatJoinRequests.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_count = map['total_count'];
    if (map['requests']) {
      requests = [];
      for (var someValue in map['requests']) {
        requests?.add(TdApiMap.fromMap(someValue) as ChatJoinRequest);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'total_count': total_count?.toMap(skipNulls: skipNulls),
      'requests': requests?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
