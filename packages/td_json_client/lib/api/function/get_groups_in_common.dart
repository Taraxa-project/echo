import 'package:td_json_client/api/base.dart';


/// Returns a list of common group chats with a given user. Chats are sorted by their type and creation date 
class GetGroupsInCommon extends TdFunction {
  String get tdType => 'getGroupsInCommon';
  String get tdReturnType => 'Chats';


  /// User identifier 
  int53? user_id;

  /// Chat identifier starting from which to return chats; use 0 for the first request 
  int53? offset_chat_id;

  /// The maximum number of chats to be returned; up to 100
  int32? limit;

  GetGroupsInCommon({
    super.extra,
    super.client_id,
    this.user_id,
    this.offset_chat_id,
    this.limit,
  });

  GetGroupsInCommon.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    offset_chat_id = map['offset_chat_id'];
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'offset_chat_id': offset_chat_id?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
