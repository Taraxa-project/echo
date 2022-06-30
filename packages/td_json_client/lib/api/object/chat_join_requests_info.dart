import 'package:td_json_client/api/base.dart';


/// Contains information about pending join requests for a chat 
class ChatJoinRequestsInfo extends TdObject {
  String get tdType => 'chatJoinRequestsInfo';


  /// Total number of pending join requests 
  int32? total_count;

  /// Identifiers of at most 3 users sent the newest pending join requests
  vector<int53>? user_ids;

  ChatJoinRequestsInfo({
    super.extra,
    super.client_id,
    this.total_count,
    this.user_ids,
  });

  ChatJoinRequestsInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_count = map['total_count'];
    if (map['user_ids'] != null) {
      user_ids = [];
      for (var someValue in map['user_ids']) {
        user_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'total_count': total_count?.toMap(skipNulls: skipNulls),
      'user_ids': user_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
