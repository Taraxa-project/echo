import 'package:td_json_client/api/base.dart';


/// Returns information about a secret chat by its identifier. This is an offline request 
class GetSecretChat extends TdFunction {
  String get tdType => 'getSecretChat';
  String get tdReturnType => 'SecretChat';

  String? extra;
  int? client_id;

  /// Secret chat identifier
  int32? secret_chat_id;

  GetSecretChat({
    this.extra,
    this.client_id,
    this.secret_chat_id,
  });

  GetSecretChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    secret_chat_id = map['secret_chat_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'secret_chat_id': secret_chat_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
