import 'package:td_json_client/api/base.dart';

class GetGroupsInCommon extends TdFunction {
  String get tdType => 'getGroupsInCommon';
  String get tdReturnType => 'Chats';

  String? extra;
  int? client_id;
  int53? user_id;
  int53? offset_chat_id;
  int32? limit;

  GetGroupsInCommon({
    this.extra,
    this.client_id,
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
