import 'package:td_json_client/src/td_api/td.dart';

/// Returns localized name of the Telegram support user; for Telegram support only
class GetSupportName extends TdFunction {
  String get tdType => 'getSupportName';
  String get tdReturnType => 'Text';

  GetSupportName({
    super.extra,
    super.client_id,
  });

  GetSupportName.fromMap(Map<String, dynamic> map) {
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
