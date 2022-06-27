import 'package:td_json_client/api/base.dart';

class GetBlockedMessageSenders extends TdFunction {
  String get tdType => 'getBlockedMessageSenders';
  String get tdReturnType => 'MessageSenders';

  string? extra;
  int? client_id;
  int32? offset;
  int32? limit;

  GetBlockedMessageSenders({
    this.extra,
    this.client_id,
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
