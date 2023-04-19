import 'package:td_json_client/src/td_api/td.dart';

/// Returns storage usage statistics. Can be called before authorization
class GetStorageStatistics extends TdFunction {
  String get tdType => 'getStorageStatistics';
  String get tdReturnType => 'StorageStatistics';

  /// The maximum number of chats with the largest storage usage for which separate statistics need to be returned. All other chats will be grouped in entries with chat_id == 0. If the chat info database is not used, the chat_limit is ignored and is always set to 0
  int32? chat_limit;

  GetStorageStatistics({
    super.extra,
    super.client_id,
    this.chat_limit,
  });

  GetStorageStatistics.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_limit = map['chat_limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_limit': chat_limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
