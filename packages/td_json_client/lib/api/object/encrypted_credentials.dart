import 'package:td_json_client/api/base.dart';

class EncryptedCredentials extends TdObject {
  String get tdType => 'encryptedCredentials';

  String? extra;
  int? client_id;
  bytes? data;
  bytes? hash;
  bytes? secret;

  EncryptedCredentials({
    this.extra,
    this.client_id,
    this.data,
    this.hash,
    this.secret,
  });

  EncryptedCredentials.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    data = map['data'];
    hash = map['hash'];
    secret = map['secret'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'data': data?.toMap(skipNulls: skipNulls),
      'hash': hash?.toMap(skipNulls: skipNulls),
      'secret': secret?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
