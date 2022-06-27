import 'package:td_json_client/api/base.dart';

class CheckAuthenticationBotToken extends TdFunction {
  String get tdType => 'checkAuthenticationBotToken';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  string? token;

  CheckAuthenticationBotToken({
    this.extra,
    this.client_id,
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
