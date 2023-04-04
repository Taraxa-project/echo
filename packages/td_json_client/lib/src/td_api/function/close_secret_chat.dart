import 'package:td_json_client/src/td_api/td.dart';

/// Closes a secret chat, effectively transferring its state to secretChatStateClosed
class CloseSecretChat extends TdFunction {
  String get tdType => 'closeSecretChat';
  String get tdReturnType => 'Ok';

  /// Secret chat identifier
  int32? secret_chat_id;

  CloseSecretChat({
    super.extra,
    super.client_id,
    this.secret_chat_id,
  });

  CloseSecretChat.fromMap(Map<String, dynamic> map) {
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
