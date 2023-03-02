import 'package:td_json_client/api/base.dart';


/// Returns users and chats that were blocked by the current user 
class GetBlockedMessageSenders extends TdFunction {
  String get tdType => 'getBlockedMessageSenders';
  String get tdReturnType => 'MessageSenders';


  /// Number of users and chats to skip in the result; must be non-negative 
  int32? offset;

  /// The maximum number of users and chats to return; up to 100
  int32? limit;

  GetBlockedMessageSenders({
    super.extra,
    super.client_id,
    this.offset,
    this.limit,
  });

  GetBlockedMessageSenders.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    offset = map['offset'];
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'offset': offset?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
