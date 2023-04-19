import 'package:td_json_client/src/td_api/td.dart';

/// Changes the database encryption key. Usually the encryption key is never changed and is stored in some OS keychain
class SetDatabaseEncryptionKey extends TdFunction {
  String get tdType => 'setDatabaseEncryptionKey';
  String get tdReturnType => 'Ok';

  /// New encryption key
  bytes? new_encryption_key;

  SetDatabaseEncryptionKey({
    super.extra,
    super.client_id,
    this.new_encryption_key,
  });

  SetDatabaseEncryptionKey.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    new_encryption_key = map['new_encryption_key'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'new_encryption_key': new_encryption_key?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
