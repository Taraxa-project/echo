import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_join_request.dart';

/// Returns pending join requests in a chat
class GetChatJoinRequests extends TdFunction {
  String get tdType => 'getChatJoinRequests';
  String get tdReturnType => 'ChatJoinRequests';

  /// Chat identifier
  int53? chat_id;

  /// Invite link for which to return join requests. If empty, all join requests will be returned. Requires administrator privileges and can_invite_users right in the chat for own links and owner privileges for other links
  string? invite_link;

  /// A query to search for in the first names, last names and usernames of the users to return
  string? query;

  /// A chat join request from which to return next requests; pass null to get results from the beginning
  ChatJoinRequest? offset_request;

  /// The maximum number of requests to join the chat to return
  int32? limit;

  GetChatJoinRequests({
    super.extra,
    super.client_id,
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
    if (map['offset_request'] != null) {
      offset_request =
          TdApiMap.fromMap(map['offset_request']) as ChatJoinRequest;
    }
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
