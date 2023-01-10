import 'package:td_json_client/api/base.dart';


/// Toggles whether a session can accept incoming secret chats 
class ToggleSessionCanAcceptSecretChats extends TdFunction {
  String get tdType => 'toggleSessionCanAcceptSecretChats';
  String get tdReturnType => 'Ok';


  /// Session identifier 
  int64? session_id;

  /// Pass true to allow accepring secret chats by the session; pass false otherwise
  Bool? can_accept_secret_chats;

  ToggleSessionCanAcceptSecretChats({
    super.extra,
    super.client_id,
    this.session_id,
    this.can_accept_secret_chats,
  });

  ToggleSessionCanAcceptSecretChats.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    session_id = map['session_id'];
    can_accept_secret_chats = map['can_accept_secret_chats'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'session_id': session_id?.toMap(skipNulls: skipNulls),
      'can_accept_secret_chats': can_accept_secret_chats?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
