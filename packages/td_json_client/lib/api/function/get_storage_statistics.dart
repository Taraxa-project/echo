import 'package:td_json_client/api/base.dart';

class GetStorageStatistics extends TdFunction {
  String get tdType => 'getStorageStatistics';
  String get tdReturnType => 'StorageStatistics';

  String? extra;
  int? client_id;
  int32? chat_limit;

  GetStorageStatistics({
    this.extra,
    this.client_id,
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
