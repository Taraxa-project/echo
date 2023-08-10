import 'package:td_json_client/src/td_api/td.dart';

/// Returns recently opened chats; this is an offline request. Returns chats in the order of last opening
class GetRecentlyOpenedChats extends TdFunction {
  String get tdType => 'getRecentlyOpenedChats';
  String get tdReturnType => 'Chats';

  /// The maximum number of chats to be returned
  int32? limit;

  GetRecentlyOpenedChats({
    super.extra,
    super.client_id,
    this.limit,
  });

  GetRecentlyOpenedChats.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
