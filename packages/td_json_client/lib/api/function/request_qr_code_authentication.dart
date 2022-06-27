import 'package:td_json_client/api/base.dart';

class RequestQrCodeAuthentication extends TdFunction {
  String get tdType => 'requestQrCodeAuthentication';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  vector<int53>? other_user_ids;

  RequestQrCodeAuthentication({
    this.extra,
    this.client_id,
    this.other_user_ids,
  });

  RequestQrCodeAuthentication.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['other_user_ids']) {
      other_user_ids = [];
      for (var someValue in map['other_user_ids']) {
        other_user_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'other_user_ids': other_user_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
