import 'package:td_json_client/api/base.dart';

class GetAccountTtl extends TdFunction {
  String get tdType => 'getAccountTtl';
  String get tdReturnType => 'AccountTtl';

  String? extra;
  int? client_id;

  GetAccountTtl({
    this.extra,
    this.client_id,
  });

  GetAccountTtl.fromMap(Map<String, dynamic> map) {
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
