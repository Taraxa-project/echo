import 'package:td_json_client/src/td_api/td.dart';

/// Checks the database encryption key for correctness. Works only when the current authorization state is authorizationStateWaitEncryptionKey
class CheckDatabaseEncryptionKey extends TdFunction {
  String get tdType => 'checkDatabaseEncryptionKey';
  String get tdReturnType => 'Ok';

  /// Encryption key to check or set up
  bytes? encryption_key;

  CheckDatabaseEncryptionKey({
    super.extra,
    super.client_id,
    this.encryption_key,
  });

  CheckDatabaseEncryptionKey.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    encryption_key = map['encryption_key'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'encryption_key': encryption_key?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
