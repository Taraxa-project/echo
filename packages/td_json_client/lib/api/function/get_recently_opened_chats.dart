import 'package:td_json_client/api/base.dart';

class GetRecentlyOpenedChats extends TdFunction {
  String get tdType => 'getRecentlyOpenedChats';
  String get tdReturnType => 'Chats';

  string? extra;
  int? client_id;
  int32? limit;

  GetRecentlyOpenedChats({
    this.extra,
    this.client_id,
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
