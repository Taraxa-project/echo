import 'package:td_json_client/api/base.dart';

class CheckDatabaseEncryptionKey extends TdFunction {
  String get tdType => 'checkDatabaseEncryptionKey';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  bytes? encryption_key;

  CheckDatabaseEncryptionKey({
    this.extra,
    this.client_id,
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
