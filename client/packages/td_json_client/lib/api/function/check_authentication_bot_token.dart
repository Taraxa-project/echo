import 'package:td_json_client/api/base.dart';


/// Checks the authentication token of a bot; to log in as a bot. Works only when the current authorization state is authorizationStateWaitPhoneNumber. Can be used instead of setAuthenticationPhoneNumber and checkAuthenticationCode to log in 
class CheckAuthenticationBotToken extends TdFunction {
  String get tdType => 'checkAuthenticationBotToken';
  String get tdReturnType => 'Ok';


  /// The bot token
  string? token;

  CheckAuthenticationBotToken({
    super.extra,
    super.client_id,
    this.token,
  });

  CheckAuthenticationBotToken.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    token = map['token'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'token': token?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
