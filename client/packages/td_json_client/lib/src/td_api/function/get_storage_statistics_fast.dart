import 'package:td_json_client/src/td_api/td.dart';

/// Quickly returns approximate storage usage statistics. Can be called before authorization
class GetStorageStatisticsFast extends TdFunction {
  String get tdType => 'getStorageStatisticsFast';
  String get tdReturnType => 'StorageStatisticsFast';

  GetStorageStatisticsFast({
    super.extra,
    super.client_id,
  });

  GetStorageStatisticsFast.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
