import 'package:td_json_client/src/td_api/td.dart';

/// Contains encrypted Telegram Passport data credentials
class EncryptedCredentials extends TdObject {
  String get tdType => 'encryptedCredentials';

  /// The encrypted credentials
  bytes? data;

  /// The decrypted data hash
  bytes? hash;

  /// Secret for data decryption, encrypted with the service's public key
  bytes? secret;

  EncryptedCredentials({
    super.extra,
    super.client_id,
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
