import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_join_request.dart';

class GetChatJoinRequests extends TdFunction {
  String get tdType => 'getChatJoinRequests';
  String get tdReturnType => 'ChatJoinRequests';

  String? extra;
  int? client_id;
  int53? chat_id;
  string? invite_link;
  string? query;
  ChatJoinRequest? offset_request;
  int32? limit;

  GetChatJoinRequests({
    this.extra,
    this.client_id,
    this.chat_id,
    this.invite_link,
    this.query,
    this.offset_request,
    this.limit,
  });

  GetChatJoinRequests.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    invite_link = map['invite_link'];
    query = map['query'];
    offset_request = TdApiMap.fromMap(map['offset_request']) as ChatJoinRequest;
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'invite_link': invite_link?.toMap(skipNulls: skipNulls),
      'query': query?.toMap(skipNulls: skipNulls),
      'offset_request': offset_request?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
